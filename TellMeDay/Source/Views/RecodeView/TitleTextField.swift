//
//  TitleTextField.swift
//  TellMeDay
//
//  Created by 전준영 on 9/22/24.
//

import SwiftUI

struct TitleTextField: View {
    var placeholder: Text
    @Binding var text: String
    var font: Font = .customFont(name: CustomFont.gyuri, size: 20)
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .padding(.leading, 5)
            }
            TextField("", text: $text)
                .font(font)
                .padding(.leading, 5)
        }
    }
}
