//
//  VoiceRecordingView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/21/24.
//

import SwiftUI

struct VoiceRecordingView: View {
    @StateObject private var speechRecognizer = SpeechRecognizer()
    
    var body: some View {
        VStack {
            Text("음성 녹음 및 텍스트 변환")
                .font(.title)
                .padding()
            
            TextEditor(text: $speechRecognizer.transcript)
                .frame(height: 300)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            HStack {
                Button(action: {
                    speechRecognizer.startTranscribing()
                }) {
                    Text("Start")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    speechRecognizer.stopTranscribing()
                }) {
                    Text("Stop")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .padding()
    }
}


#Preview {
    VoiceRecordingView()
}
