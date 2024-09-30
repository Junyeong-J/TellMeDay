//
//  AnalyzeView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/29/24.
//

import SwiftUI

struct LeafShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.minY),
            control: CGPoint(x: rect.maxX * 1.5, y: rect.maxY * 0.5)
        )
        
        path.addQuadCurve(
            to: CGPoint(x: rect.midX, y: rect.maxY),
            control: CGPoint(x: rect.maxX * 0.5, y: rect.maxY * 0.8)
        )
        
        path.addQuadCurve(
            to: CGPoint(x: rect.minX, y: rect.minY),
            control: CGPoint(x: rect.minX - rect.maxX * 0.5, y: rect.maxY * 0.5)
        )
        
        path.addQuadCurve(
            to: CGPoint(x: rect.midX, y: rect.maxY),
            control: CGPoint(x: rect.maxX * 0.5, y: rect.maxY * 0.8)
        )
        return path
    }
}

struct AnalyzeView: View {
    
    @State private var animatePercentage: Double = 0
    @State private var dateRangeText: String = ""
    @State private var emotionCounts: [String: Int] = ["기쁨": 0, "공포": 0, "분노": 0, "슬픔": 0]
    var repository = ListTableRepository()
    
    var body: some View {
        VStack {
            Text("나무는 당신의 감정으로 채워집니다 - 각각의 잎사귀가 고유한 감정을 담고 있어요.")
                .font(Font.customFont(name: CustomFont.gyuri, size: 25))
                .foregroundColor(.appBlackAndWhite)
                .padding(.top)
                .padding(.horizontal)
            
            ZStack {
                Path { path in

                    path.move(to: CGPoint(x: 115, y: 250))
                    path.addLine(to: CGPoint(x: 115, y: 100))
                    path.move(to: CGPoint(x: 125, y: 250))
                    path.addLine(to: CGPoint(x: 125, y: 100))
                    path.move(to: CGPoint(x: 135, y: 250))
                    path.addLine(to: CGPoint(x: 135, y: 100))
                    
                    path.move(to: CGPoint(x: 135, y: 105))
                    path.addLine(to: CGPoint(x: 210, y: 60))
                    path.move(to: CGPoint(x: 172, y: 78))
                    path.addLine(to: CGPoint(x: 210, y: 110))
                    
                    path.move(to: CGPoint(x: 40, y: 60))
                    path.addLine(to: CGPoint(x: 120, y: 110))
                    path.move(to: CGPoint(x: 70, y: 75))
                    path.addLine(to: CGPoint(x: 40, y: 110))
                    
                    path.move(to: CGPoint(x: 135, y: 20))
                    path.addLine(to: CGPoint(x: 125, y: 100))
                    path.move(to: CGPoint(x: 135, y: 40))
                    path.addLine(to: CGPoint(x: 80, y: 30))
                }
                .stroke(Color.brown, lineWidth: 10)
                
                ZStack {
                    ForEach(0..<totalLeafCount(), id: \.self) { index in
                        LeafShape()
                            .fill(colorForLeaf(at: index))
                            .frame(width: 30, height: 50)
                            .offset(randomOffset(for: index))
                    }
                }
            }
            .frame(width: 250, height: 250)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray.opacity(0.2))
            )
            .padding(.vertical)
            
            Text("저장소에 넣어둔 기간")
                .font(Font.customFont(name: CustomFont.gyuri, size: 24))
                .asForeground(.appBlackAndWhite)
            
            Text(FormatterManager.shared.updateDateRangeText())
                .font(Font.customFont(name: CustomFont.gyuri, size: 24))
                .asForeground(.appBlackAndWhite)
                .padding(.bottom, 5)
            
            HStack(spacing: 15) {
                CustomBarMark(color: .red, percentage: percentage(for: "분노"), emotionName: "분노", animatePercentage: $animatePercentage)
                CustomBarMark(color: .yellow, percentage: percentage(for: "공포"), emotionName: "공포", animatePercentage: $animatePercentage)
                CustomBarMark(color: .green, percentage: percentage(for: "기쁨"), emotionName: "기쁨", animatePercentage: $animatePercentage)
                CustomBarMark(color: .blue, percentage: percentage(for: "슬픔"), emotionName: "슬픔", animatePercentage: $animatePercentage)
            }
            .frame(height: 150)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.gray.opacity(0.3))
            )
            .onAppear {
                animatePercentage = 1.0
                updateEmotionCounts()
            }
            Spacer()
        }
        .padding()
        .background(.appBaseBackground)
    }
    
    func colorForLeaf(at index: Int) -> Color {
        let emotions = sortedEmotions()
        let emotion = emotions[index % emotions.count]
        
        switch emotion {
        case "분노": return .red
        case "공포": return .yellow
        case "기쁨": return .green
        case "슬픔": return .blue
        default: return .gray
        }
    }
    
    func updateEmotionCounts() {
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        
        let entries = repository.fetchEntries(for: year, month: month)
        
        var counts: [String: Int] = ["기쁨": 0, "공포": 0, "분노": 0, "슬픔": 0]
        
        for entry in entries {
            if let emotion = entry.emotion {
                counts[emotion, default: 0] += 1
            }
        }
        
        self.emotionCounts = counts
    }
    
    func totalLeafCount() -> Int {
        return emotionCounts.values.reduce(0, +)
    }
    
    func percentage(for emotion: String) -> Double {
        let totalCount = Double(totalLeafCount())
        guard totalCount > 0 else { return 0 }
        
        return (Double(emotionCounts[emotion] ?? 0) / totalCount) * 100
    }
    
    func sortedEmotions() -> [String] {
        var emotions: [String] = []
        
        for (emotion, count) in emotionCounts {
            emotions += Array(repeating: emotion, count: count)
        }
        
        return emotions
    }
    
    func randomOffset(for index: Int) -> CGSize {
        let xPosition = CGFloat.random(in: -100...100)
        let yPosition = CGFloat.random(in: -150...0)
        return CGSize(width: xPosition, height: yPosition)
    }
}

struct CustomBarMark: View {
    let color: Color
    let percentage: Double
    let emotionName: String
    @Binding var animatePercentage: Double
    
    var body: some View {
        VStack {
            Spacer()
            RoundedRectangle(cornerRadius: 5)
                .fill(color)
                .frame(height: CGFloat(percentage) * animatePercentage)
            Text("\(Int(percentage))%")
                .foregroundColor(.appBlackAndWhite)
                .font(.caption)
            Text(emotionName)
                .foregroundColor(.appBlackAndWhite)
                .font(.caption)
        }
    }
}


struct TreeChartView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyzeView()
    }
}
