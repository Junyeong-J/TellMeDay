//
//  VoiceDiaryRecordingView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/24/24.
//

import SwiftUI

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
    
    let selectedDate: Date
    let title: String
    let category: String
    private let repository = ListTableRepository()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    dateHeaderView(dateText: viewModel.output.selectedDate)
                    
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
                                    withAnimation(.easeOut) {
                                        viewModel.input.playButtonTapped.send(())
                                    }
                                }) {
                                    Image(systemName: viewModel.output.isPlaying ? "pause.circle" : "play.circle")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .asForeground(.appBlackAndWhite)
                                }
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
                    
                    Text("""
                        최대 녹음 시간은 3분입니다.
                        음성 텍스트(STT)는 최대 500자까지 저장되며, 500자가 초과되면 더 이상 텍스트로 변환되지 않습니다.
                        그러나 녹음은 계속 진행되며, 파일은 자동으로 앱의 'Documents' 폴더에 저장됩니다.
                        """)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    .padding(.bottom, 120)
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
                                        
                                        let positiveScore = sentimentData.first(where: { $0.emotion == "긍정" })?.percentage ?? 0
                                        let negativeScore = sentimentData.first(where: { $0.emotion == "부정" })?.percentage ?? 0
                                        viewModel.saveDiaryEntry(category: category, title: title, positiveScore: positiveScore, negativeScore: negativeScore, emotion: emotion)
                                    } else {
                                        // 오류 처리
                                    }
                                }
                            }
                        }) {
                            Text("저장 및 분석")
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
        }
    }
}


#Preview {
    VoiceDiaryRecordingView(firstNaviLinkActive: .constant(true), selectedDate: Date(), title: "", category: "")
}
