//
//  DateHeaderView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/24/24.
//

import SwiftUI

private struct DateHeaderView: ViewModifier {
    
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
    func dateHeaderView(dateText: String) -> some View {
        self.modifier(DateHeaderView(dateText: dateText))
    }
}
