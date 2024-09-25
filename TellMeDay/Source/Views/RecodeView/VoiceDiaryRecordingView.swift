//
//  VoiceDiaryRecordingView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/24/24.
//

import SwiftUI

struct VoiceDiaryRecordingView: View {
    
    @StateObject private var viewModel = VoiceDiaryRecordingViewModel()
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Text("")
                        .dateHeaderView(dateText: viewModel.output.selectedDate)
                    
                    Spacer()
                    
                    VStack(spacing: 10) {
                        
                        TextEditor(text: $viewModel.output.transcript)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .frame(height: 200)
                            .padding(.horizontal, 20)
                            .transition(.opacity)
                            .animation(.easeInOut, value: viewModel.output.isPlaying)
                        
                        Text(viewModel.output.timerText)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                            .offset(y: viewModel.output.timerPosition ? geometry.size.height * 0.2 : 0)
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
                                        .foregroundColor(.black)
                                }
                                .offset(y: viewModel.output.isPlaying || viewModel.output.showStopButton ? geometry.size.height * 0.2 : 0)
                                .animation(.easeOut, value: viewModel.output.isPlaying)
                            }
                            
                            if viewModel.output.showStopButton {
                                Button(action: {
                                    withAnimation(.easeOut) {
                                        viewModel.input.stopButtonTapped.send(())
                                    }
                                }) {
                                    Image(systemName: "stop.circle")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.red)
                                }
                                .offset(y: geometry.size.height * 0.2)
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
                                        .foregroundColor(.black)
                                }
                                .offset(y: geometry.size.height * 0.2)
                                .animation(.easeOut, value: viewModel.output.isPlaying)
                            }
                        }
                        
//                        Button(action: {
//                            print(viewModel.output.transcript)
//                        }) {
//                            Text("STT 결과 출력")
//                                .font(.headline)
//                                .padding()
//                                .background(Color.blue)
//                                .foregroundColor(.white)
//                                .cornerRadius(10)
//                        }
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
                    
                }
            }
        }
    }
}

#Preview {
    VoiceDiaryRecordingView()
}
