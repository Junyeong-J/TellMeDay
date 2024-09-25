//
//  TabIconView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/25/24.
//

import SwiftUI

private struct TabIconView: ViewModifier {
    
    var isSelected: Bool
    var systemName: String
    
    func body(content: Content) -> some View {
        VStack(alignment: .center) {
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(width: 22)
        }
        .foregroundStyle(isSelected ? Color.appMain : Color.gray)
        .padding()
        .offset(y: -20)
    }
}

extension View {
    func tabIconView(isSelected: Bool, systemName: String) -> some View {
        self.modifier(TabIconView(isSelected: isSelected, systemName: systemName))
    }
}
