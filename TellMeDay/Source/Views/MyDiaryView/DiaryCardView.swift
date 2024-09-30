//
//  DiaryCardView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/29/24.
//

import SwiftUI

struct DiaryCardView: View {
    let entry: DiaryEntry
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            
            EmotionImageManager.emojiImage(for: entry.emotion ?? "기쁨")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding(.top, 16)
            
            Text(FormatterManager.shared.recodingDateHeader(entry.selectedDate))
                            .font(Font.customFont(name: CustomFont.gyuri, size: 20))
                            .asForeground(.appGrayAndWhite)
                            .padding(.top, 8)
            
            Text(entry.content ?? "")
                .font(Font.customFont(name: CustomFont.gyuri, size: 20))
                .asForeground(.appBlackAndWhite)
                .padding(.top, 8)
                .padding(.horizontal, 16)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.appTabBar)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal, 10)
    }
}



