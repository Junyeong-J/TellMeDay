//
//  CircleButtonView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/25/24.
//

import SwiftUI

struct CircleButtonView: View {
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            Image(systemName: "pencil.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.appMain)
        }
        .background(
            Circle()
                .fill(Color.white)
                .shadow(color: .appMain.opacity(0.15), radius: 8, y: 2)
        )
    }
}
