//
//  VoiceRecordingView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/21/24.
//

import SwiftUI
import AVFoundation
import Speech

struct VoiceRecordingView: View {
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @State private var isPlaying = false
    @State private var buttonPosition: CGPoint = .zero
    @State private var isAtBottom = false
    @State private var elapsedTime: Int = 0
    @State private var timer: Timer?
    @State private var isRecordingFinished = false
    @State private var sttText: String = ""
    
    var selectedDate: Date
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Text(formattedDate(selectedDate))
                        .font(.headline)
                        .padding(.top, 20)
                    
                    Spacer()
                    
                    if elapsedTime > 0 || isPlaying || isRecordingFinished {
                        TextEditor(text: $speechRecognizer.transcript)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .frame(width: geometry.size.width - 40, height: geometry.size.height / 2)
                            .padding(.horizontal, 20)
                    }
                    
                    ZStack {
                        Button(action: {
                            if !isRecordingFinished {
                                withAnimation {
                                    isPlaying.toggle()
                                    if isPlaying {
                                        if !isAtBottom {
                                            buttonPosition = CGPoint(x: geometry.size.width / 2, y: geometry.size.height - 600)
                                            isAtBottom = true
                                        }
                                        startRecording()
                                    } else {
                                        stopRecording()
                                    }
                                }
                            }
                        }) {
                            Image(systemName: isPlaying ? "pause.circle" : "play.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(isRecordingFinished ? .gray : .red)
                        }
                        .position(buttonPosition == .zero ? CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2 - 50) : buttonPosition)
                        
                        if isAtBottom {
                            HStack {
                                Button(action: {
                                    isPlaying = false
                                    stopRecording()
                                }) {
                                    Image(systemName: "stop.circle")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.red)
                                }
                                
                                Text("\(formattedTime(elapsedTime))")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding(.leading, 10)
                                
                            }
                            .position(x: buttonPosition.x + 90, y: buttonPosition.y)
                        }
                    }
                    
                    Spacer()
                    
                    Text("""
                        최대 녹음 시간은 3분입니다.
                        녹음 파일은 앱의 'Documents' 폴더에 저장됩니다.
                        녹음 파일을 직접 삭제할 경우, 앱에서 파일을 재생할 수 없습니다.
                        """)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
                .onAppear {
                    if buttonPosition == .zero {
                        buttonPosition = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2 - 50)
                    }
                }
            }
        }
    }
    
    private func startRecording() {
        speechRecognizer.startTranscribing()
        startTimer()
    }
    
    private func stopRecording() {
        speechRecognizer.stopTranscribing()
        stopTimer()
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            elapsedTime += 1
            if elapsedTime >= 180 {
                stopRecording()
                isRecordingFinished = true
                isPlaying = false
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func formattedTime(_ time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: date)
    }
}



#Preview {
    VoiceRecordingView(selectedDate: Date())
}
