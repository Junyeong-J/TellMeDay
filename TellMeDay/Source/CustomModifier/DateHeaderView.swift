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
                .foregroundColor(.gray)
            
            Text(dateText)
                .font(Font.customFont(name: CustomFont.gyuri, size: 25))
                .asForeground(.black)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
}

extension View {
    func dateHeaderView(dateText: String) -> some View {
        self.modifier(DateHeaderView(dateText: dateText))
    }
}
