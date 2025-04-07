//
//  DiaryDetailView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/29/24.
//

import SwiftUI

struct DiaryDetailView: View {
    
    @State var entry: DiaryEntry
    @Binding var firstNaviLinkActive: Bool
    @Binding var hideDiaryTabBar: Bool
    @StateObject private var audioRecorderManager = AudioRecorderManager()
    @State private var playbackProgress: Double = 0
    @State private var isPlaying: Bool = false
    @State private var timer: Timer?
    @State private var totalDuration: String = "00:00"
    @Environment(\.dismiss) var dismiss
    var repository = ListTableRepository()
    @State private var isNavigatingToEdit: Bool = false
    @State private var showAlert = false
    var body: some View {
        VStack {
            Text(entry.title)
                .font(Font.customFont(name: CustomFont.gyuri, size: 30))
                .foregroundColor(.appBlackAndWhite)
                .padding(.bottom, 5)
            Text("\(entry.parentFolder.first?.category ?? StringData.DiaryDetail.noCategory) 긍정: \(entry.positiveScore ?? 0)%, 부정: \(entry.negativeScore ?? 0)%")
                .font(Font.customFont(name: CustomFont.gyuri, size: 20))
                .foregroundColor(.appGrayAndWhite)
                .padding(.bottom, 10)
            
            EmotionImageManager.emojiImage(for: entry.emotion ?? "기쁨")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
            
            Text(FormatterManager.shared.recodingDateHeader(entry.selectedDate))
                .font(Font.customFont(name: CustomFont.gyuri, size: 20))
                .foregroundColor(.appGrayAndWhite)
                .padding(.bottom, 10)
            
            ScrollView {
                Text(entry.content ?? StringData.DiaryDetail.noContent)
                    .font(Font.customFont(name: CustomFont.gyuri, size: 18))
                    .padding()
                    .background(Color.appWhiteAndGray)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            .scrollIndicators(.hidden)
            
            Spacer()
            
            VStack {
                Slider(value: $playbackProgress, in: 0...1, onEditingChanged: sliderEditingChanged)
                    .padding(.horizontal)
                    .accentColor(.appMain)
                HStack {
                    Text(audioRecorderManager.audioPlayer?.currentTimeString ?? "00:00")
                        .font(.subheadline)
                    Spacer()
                    Text(totalDuration)
                        .font(.subheadline)
                }
                .padding(.horizontal)
            }
            .padding()
            
            Button(action: {
                if isPlaying {
                    audioRecorderManager.pausePlaying()
                    stopTimer()
                } else {
                    if let audioPath = entry.audioFilePath {
                        audioRecorderManager.startPlaying(with: audioPath)
                        startTimer()
                    }
                }
                isPlaying.toggle()
            }) {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.appBlackAndWhite)
            }
            .padding()
        }
        .background(Color.appBaseBackground.edgesIgnoringSafeArea(.all))
        
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    //                    firstNaviLinkActive = false
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .asForeground(.appBlackAndWhite)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    NavigationLink(
                        destination: EditDiary(entry: $entry)
                            .onAppear { isNavigatingToEdit = true }
                            .onDisappear { isNavigatingToEdit = false }
                    ) {
                        Image(systemName: "pencil.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .asForeground(.appBlackAndWhite)
                    }
                    
                    Button(action: {
                        showAlert = true
                    }) {
                        Image(systemName: "trash.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .asForeground(.appBlackAndWhite)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text(StringData.DiaryDetail.deleteTitle),
                            message: Text(StringData.DiaryDetail.deleteMessage),
                            primaryButton: .destructive(Text(StringData.DiaryDetail.deleteConfirm)) {
                                deleteEntry()
                            },
                            secondaryButton: .cancel(Text(StringData.DiaryDetail.cancel))
                        )
                    }
                }
            }
        }
        .onAppear {
            if let updatedEntry = repository.fetchEntry(by: entry.id) {
                self.entry = updatedEntry
            }
            if let audioPath = entry.audioFilePath {
                audioRecorderManager.loadAudioFile(with: audioPath)
                if let player = audioRecorderManager.audioPlayer {
                    totalDuration = player.durationString
                }
            }
        }
        .onReceive(audioRecorderManager.$isPlaying) { isPlaying in
            if !isPlaying {
                self.isPlaying = false
            }
        }
        .onChange(of: entry) { _ in
            reloadData()
        }
        .onDisappear {
            stopPlayback()
        }
        .onDisappear {
            if !isNavigatingToEdit {
                hideDiaryTabBar = false
            }
            stopPlayback()
        }
    }
    
    func reloadData() {
        if let audioPath = entry.audioFilePath {
            audioRecorderManager.loadAudioFile(with: audioPath)
            if let player = audioRecorderManager.audioPlayer {
                totalDuration = player.durationString
            }
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            updatePlaybackProgress()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func sliderEditingChanged(editingStarted: Bool) {
        if !editingStarted, let player = audioRecorderManager.audioPlayer {
            player.currentTime = player.duration * playbackProgress
        }
    }
    
    func updatePlaybackProgress() {
        if let player = audioRecorderManager.audioPlayer {
            playbackProgress = player.currentTime / player.duration
        }
    }
    
    func stopPlayback() {
        audioRecorderManager.stopPlaying()
        stopTimer()
        isPlaying = false
    }
    
    func deleteEntry() {
        if let audioFileName = entry.audioFilePath {
            let fullPath = getFullAudioPath(for: audioFileName)
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: fullPath) {
                do {
                    try fileManager.removeItem(atPath: fullPath)
                    print("녹음 파일 삭제 완료")
                } catch {
                    print("녹음 파일 삭제 실패: \(error)")
                }
            }
        }
        repository.deleteEntryAndFolderIfNeeded(entry)
        entry = DiaryEntry()
        firstNaviLinkActive = false
        dismiss()
    }
    
    func getFullAudioPath(for fileName: String) -> String {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent(fileName).path
    }
}

