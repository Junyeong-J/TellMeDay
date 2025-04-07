//
//  EditDiary.swift
//  TellMeDay
//
//  Created by 전준영 on 9/29/24.
//

import SwiftUI

struct EditDiary: View {
    
    @Binding var entry: DiaryEntry
    @StateObject private var viewModel = EditDiaryViewModel()
    @State private var selectedCategory: String = StringData.Category.everyday
    
    let categories = StringData.Category.all
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            dateHeaderView(dateText: viewModel.output.selectedDate)
            
            categoriesView(selectedCategory: $selectedCategory, categories: categories)
                .onAppear {
                    if let folderCategory = entry.parentFolder.first?.category {
                        selectedCategory = folderCategory
                        viewModel.input.selectedCategory = folderCategory
                    }
                    viewModel.output.title = entry.title
                }
                .onChange(of: selectedCategory) { newCategory in
                    viewModel.input.selectedCategory = newCategory
                    viewModel.output.customCategoryVisible = (newCategory == StringData.Category.etc)
                }
            
            if viewModel.output.customCategoryVisible {
                TitleTextField(
                    placeholder: Text(StringData.Common.categoryInput)
                        .font(Font.customFont(name: CustomFont.gyuri, size: 20))
                        .foregroundColor(.gray),
                    text: $viewModel.input.customCategory
                )
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                .padding(.horizontal)
            }
            
            VStack(alignment: .leading) {
                Text(StringData.Common.title)
                    .font(Font.customFont(name: CustomFont.gyuri, size: 35))
                    .asForeground(.appBlackAndWhite)
                    .padding(.leading)
                
                TitleTextField(
                    placeholder: Text(StringData.Common.enterTitle)
                        .font(Font.customFont(name: CustomFont.gyuri, size: 20))
                        .foregroundColor(.gray),
                    text: $viewModel.output.title
                )
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                .disabled(viewModel.output.isSkipTitle)
                .onChange(of: viewModel.output.title) { newTitle in
                    viewModel.updateTitle(newTitle)
                }
                
                Button(action: {
                    viewModel.toggleSkipTitle()
                }) {
                    Text(viewModel.output.isSkipTitle ? StringData.Common.writeTitle : StringData.Common.skipTitle)
                        .font(Font.customFont(name: CustomFont.gyuri, size: 20))
                        .asForeground(.appGrayAndWhite)
                        .padding(.horizontal)
                }
            }
            .padding()
            
            Spacer()
        }
        .background(.appBaseBackground)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .asForeground(.appBlackAndWhite)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.updateEntry(entry) {
                        dismiss()
                    }
                }) {
                    Text(StringData.Common.modify)
                        .font(.headline)
                        .asForeground(.appBlackAndWhite)
                }
            }
        }
        .onAppear {
            viewModel.input.selectedDate = entry.selectedDate
            viewModel.output.title = entry.title
            viewModel.transform()
        }
    }
}
