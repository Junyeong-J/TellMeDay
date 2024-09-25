//
//  DateRecodingView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/26/24.
//

import SwiftUI

private struct DateRecodingView: ViewModifier {
    
    let dateText: String
    
    func body(content: Content) -> some View {
        HStack {
            Rectangle()
                .frame(height: 1)
                .asForeground(.appGrayAndWhite)
            
            Text(dateText)
                .font(Font.customFont(name: CustomFont.gyuri, size: 32))
                .asForeground(.appGrayAndWhite)
            
            Rectangle()
                .frame(height: 1)
                .asForeground(.appGrayAndWhite)
        }
        .padding(.horizontal)
    }
}

extension View {
    func dateRecodingView(dateText: String) -> some View {
        self.modifier(DateRecodingView(dateText: dateText))
    }
}
