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
    @State private var elapsedTime: Int = 0
    @State private var timer: Timer?
    @State private var isRecordingFinished = false
    
    @StateObject private var viewModel = VoiceRecordingViewModel()
    
    var selectedDate: Date
    
    var body: some View {
        NavigationView {
            VStack {
                Text(viewModel.output.selectedDate)
                    .font(.headline)
                    .padding(.top, 20)
                
                Spacer()
                
                if elapsedTime > 0 || isRecordingFinished {
                    TextEditor(text: $speechRecognizer.transcript)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .frame(height: 200)
                        .padding(.horizontal, 20)
                        .transition(.opacity)
                        .animation(.easeInOut, value: isPlaying || isRecordingFinished)
                }
                
                HStack(spacing: 40) {
                    Button(action: {
                        if !isRecordingFinished {
                            withAnimation(.easeInOut) {
                                isPlaying.toggle()
                            }
                            if isPlaying {
                                startRecording()
                            } else {
                                pauseRecording()
                            }
                        }
                    }) {
                        Image(systemName: isPlaying ? "pause.circle" : "play.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(isRecordingFinished ? .gray : .red)
                            .animation(.spring(), value: isPlaying)
                    }
                    
                    if isPlaying || isRecordingFinished {
                        Button(action: {
                            stopRecording()
                        }) {
                            Image(systemName: "stop.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.red)
                                .transition(.scale)
                                .animation(.spring(), value: isPlaying || isRecordingFinished)
                        }
                    }
                }
                .padding(.bottom, 20)
                
                if isRecordingFinished || isPlaying || elapsedTime > 0 {
                    Text("\(formattedTime(elapsedTime))")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.bottom, 20)
                        .transition(.slide)
                        .animation(.easeInOut, value: elapsedTime)
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
                viewModel.input.selectedDate = selectedDate
            }
        }
    }
    
    private func startRecording() {
        withAnimation(.easeInOut) {
            speechRecognizer.startTranscribing()
        }
        startTimer()
    }
    
    private func pauseRecording() {

        withAnimation(.easeInOut) {
            isPlaying = false
        }
    }
    
    private func stopRecording() {
        speechRecognizer.stopTranscribing()
        stopTimer()
        withAnimation(.easeInOut) {
            isRecordingFinished = true
        }
        isPlaying = false
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            withAnimation(.easeInOut) {
                elapsedTime += 1
            }
            if elapsedTime >= 180 {
                stopRecording()
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


//#Preview {
//    VoiceRecordingView(selectedDate: Date())
//}
