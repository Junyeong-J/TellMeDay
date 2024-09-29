//
//  AnalysisResultView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/27/24.
//

import SwiftUI
import Charts

struct AnalysisResultView: View {
    
    let emotion: String
    let sentimentData: [SentimentData]
    @Binding var firstNaviLinkActive: Bool
    
    @State private var animatePercentage: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.appWhiteAndGray)
                    .shadow(radius: 3)
                    .frame(height: geometry.size.height * 0.4)
                    .overlay(
                        VStack {
                            Text("감정 분석 결과")
                                .font(Font.customFont(name: CustomFont.gyuri, size: 35))
                                .padding()

                            Chart {
                                ForEach(sentimentData) { data in
                                    BarMark(
                                        x: .value("비율", animatePercentage * data.percentage / 100),
                                        y: .value("감정", data.emotion)
                                    )
                                    .foregroundStyle(by: .value("감정", data.emotion))
                                }
                            }
                            .chartXScale(domain: 0...100)
                            .chartXAxis {
                                AxisMarks(position: .bottom, values: .stride(by: 10)) {
                                    AxisTick(stroke: StrokeStyle(lineWidth: 1))
                                    AxisValueLabel()
                                }
                            }
                            .chartYAxis {
                                AxisMarks(position: .leading) {
                                    AxisGridLine(stroke: StrokeStyle(lineWidth: 1))
                                    AxisTick(stroke: StrokeStyle(lineWidth: 1))
                                    AxisValueLabel()
                                }
                            }
                            .chartForegroundStyleScale([
                                "긍정": Color.blue,
                                "부정": Color.red
                            ])
                            .chartPlotStyle { plotArea in
                                plotArea
                                    .background(Color.gray.opacity(0.1))
                            }
                            .padding()
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    withAnimation(.easeInOut(duration: 2.0)) {
                                        animatePercentage = 100.0
                                    }
                                }
                            }
                        }
                    )
                    .padding()

                Text("오늘의 기분입니다")
                    .font(Font.customFont(name: CustomFont.gyuri, size: 35))
                    .padding(.top)
                
                EmotionImageManager.emojiImage(for: emotion)
                    .resizable()
                    .scaledToFit()
                    .frame(height: geometry.size.height * 0.2)
                    .padding()

                Spacer()
                
                Button(action: {
                    firstNaviLinkActive = false
                }) {
                    Text("메인 페이지로 가기")
                        .font(.headline)
                        .asForeground(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.appMain)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal)
            }
            .padding()
            .background(Color.appBaseBackground)
            .navigationBarBackButtonHidden(true)
            .chartLegend(.hidden)
        }
        .onAppear {
            print("emotion: \(emotion), sentimentData: \(sentimentData)")
        }
    }
}

struct SentimentData: Identifiable {
    let id = UUID()
    let emotion: String
    let percentage: Double
}

//struct AnalysisResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnalysisResultView(emotion: "기쁨", sentimentData: [SentimentData(emotion: "기쁨", percentage: 70)], firstNaviLinkActive: .constant(true))
//    }
//}
