//
//  VoiceDiaryRecordingView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/24/24.
//

import SwiftUI
import AVFoundation

struct VoiceDiaryRecordingView: View {
    
    @StateObject private var viewModel = VoiceDiaryRecordingViewModel()
    @StateObject private var audioRecorderManager = AudioRecorderManager()
    @Environment(\.dismiss) var dismiss
    @Binding var firstNaviLinkActive: Bool
    @State private var showAnalysisResult = false
    @State private var analysisResult: String?
    @State private var sentimentData: [SentimentData] = []
    @State private var emotion: String = ""
    @State private var isAnalyzeButtonEnabled = false
    @State private var showAlert = false
    
    let selectedDate: Date
    let title: String
    let category: String
    private let repository = ListTableRepository()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    dateHeaderView(dateText: FormatterManager.shared.recodingDateHeader(selectedDate))
                    
                    VStack(spacing: 10) {
                        
                        TextEditor(text: $viewModel.output.transcript)
                            .font(Font.customFont(name: CustomFont.gyuri, size: 20))
                            .padding()
                            .background(.appBaseBackground)
                            .cornerRadius(8)
                            .frame(height: geometry.size.height * 0.45)
                            .padding(.horizontal, 20)
                            .disabled(true)
                            .transition(.opacity)
                            .animation(.easeInOut, value: viewModel.output.isPlaying)
                            .onChange(of: viewModel.output.transcript) { newValue in
                                if newValue.count > 500 {
                                    viewModel.output.transcript = String(newValue.prefix(500))
                                }
                            }
                        
                        Text(viewModel.output.timerText)
                            .font(.largeTitle)
                            .padding(.bottom, 10)
                            .asForeground(.appBlackAndWhite)
                            .animation(.easeOut, value: viewModel.output.isPlaying)
                        
                        HStack(spacing: 20) {
                            if viewModel.output.playShow {
                                Button(action: {
                                    checkMicrophonePermission { granted in
                                        if granted {
                                            withAnimation(.easeOut) {
                                                viewModel.input.playButtonTapped.send(())
                                            }
                                        } else {
                                            showAlert = true
                                        }
                                    }
                                }) {
                                    Image(systemName: viewModel.output.isPlaying ? "pause.circle" : "play.circle")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .asForeground(!viewModel.output.isStop ? .appBlackAndWhite : .gray)
                                }
                                .disabled(viewModel.output.isStop)
                                .animation(.easeOut, value: viewModel.output.isPlaying)
                            }
                            
                            if viewModel.output.showStopButton {
                                Button(action: {
                                    withAnimation(.easeOut) {
                                        viewModel.input.stopButtonTapped.send(())
                                        isAnalyzeButtonEnabled = true
                                    }
                                }) {
                                    Image(systemName: "stop.circle")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .asForeground(.red)
                                }
                                .animation(.easeOut, value: viewModel.output.showStopButton)
                            }
                            
                            if viewModel.output.listenButton {
                                Button(action: {
                                    withAnimation(.easeOut) {
                                        viewModel.input.listenButtonTapped.send(())
                                    }
                                }) {
                                    Image(systemName: viewModel.output.isPlaying ? "pause.circle" : "play.circle")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .asForeground(.appBlackAndWhite)
                                }
                                .animation(.easeOut, value: viewModel.output.isPlaying)
                            }
                        }
                    }
                    Spacer()
                    
                    Text(StringData.VoiceDiary.maxRecordingInfo)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                        .padding(.bottom, 100)
                }
                .background(.appBaseBackground)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .asForeground(.appBlackAndWhite)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            AnalyzeSentimentNetwork.shared.analyzeSentiment(text: viewModel.output.transcript) { data, emotion in
                                DispatchQueue.main.async {
                                    if let sentimentData = data, let emotion = emotion {
                                        self.sentimentData = sentimentData
                                        self.emotion = emotion
                                        showAnalysisResult = true
                                        
                                        let positiveScore = sentimentData.first(where: { $0.emotion == "positive" })?.percentage ?? 0
                                        let negativeScore = sentimentData.first(where: { $0.emotion == "negative" })?.percentage ?? 0
                                        viewModel.saveDiaryEntry(category: category, title: title, positiveScore: positiveScore, negativeScore: negativeScore, emotion: emotion)
                                    } else {
                                        // 오류 처리
                                    }
                                }
                            }
                        }) {
                            Text(StringData.VoiceDiary.saveAndAnalyze)
                                .font(.headline)
                                .asForeground(isAnalyzeButtonEnabled ? .appBlackAndWhite : .gray)
                        }
                        .disabled(!isAnalyzeButtonEnabled)
                    }
                }
                NavigationLink(destination: AnalysisResultView(emotion: emotion, sentimentData: sentimentData, firstNaviLinkActive: $firstNaviLinkActive), isActive: $showAnalysisResult) {
                    EmptyView()
                }
            }
            .onAppear {
                viewModel.input.selectedDate = selectedDate
                print("Title: \(title), Category: \(category)")
                repository.detectRealmURL()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(StringData.VoiceDiary.micPermissionDeniedTitle),
                    message: Text(StringData.VoiceDiary.micPermissionDeniedMessage),
                    primaryButton: .default(Text(StringData.VoiceDiary.goToSettings), action: {
                        if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(appSettings)
                        }
                    }),
                    secondaryButton: .cancel(Text(StringData.VoiceDiary.cancel))
                )
            }
            
        }
    }
    
    private func checkMicrophonePermission(completion: @escaping (Bool) -> Void) {
        let microphoneStatus = AVCaptureDevice.authorizationStatus(for: .audio)
        
        switch microphoneStatus {
        case .authorized:
            completion(true)
        case .denied, .restricted:
            showAlert = true
            completion(false)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .audio) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        @unknown default:
            completion(false)
        }
    }
    
}


#Preview {
    VoiceDiaryRecordingView(firstNaviLinkActive: .constant(true), selectedDate: Date(), title: "", category: "")
}
