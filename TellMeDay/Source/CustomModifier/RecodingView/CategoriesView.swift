//
//  CategoriesView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/26/24.
//

import SwiftUI

private struct CategoriesView: ViewModifier {
    
    @Binding var selectedCategory: String
    let categories: [String]
    
    func body(content: Content) -> some View {
        HStack {
            Text(StringData.Common.categorySelect)
                .font(Font.customFont(name: CustomFont.gyuri, size: 35))
                .asForeground(.appBlackAndWhite)
                .padding(.leading)
            
            Menu {
                Picker(selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category)
                            .tag(category)
                    }
                } label: {
                    EmptyView()
                }
            } label: {
                Text(selectedCategory)
                    .font(Font.customFont(name: CustomFont.gyuri, size: 25))
                    .asForeground(.appBlackAndWhite)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
            }
            .padding(.leading)
            
            Spacer()
        }
        .padding(.leading, 16)
    }
}

extension View {
    func categoriesView(selectedCategory: Binding<String>, categories: [String]) -> some View {
        self.modifier(CategoriesView(selectedCategory: selectedCategory, categories: categories))
    }
}
