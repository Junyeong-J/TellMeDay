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
    @State private var selectedCategory: String = "일상생활"
    let categories = ["일상생활", "영화", "여행", "기타"]
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
                    if newCategory == "기타" {
                        viewModel.output.customCategoryVisible = true
                    } else {
                        viewModel.output.customCategoryVisible = false
                    }
                }
            
            if viewModel.output.customCategoryVisible {
                TitleTextField(placeholder: Text("카테고리 입력하기").font(Font.customFont(name: CustomFont.gyuri, size: 20)).foregroundColor(.gray), text: $viewModel.input.customCategory)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    .padding(.horizontal)
            }
            
            VStack(alignment: .leading) {
                Text("제목")
                    .font(Font.customFont(name: CustomFont.gyuri, size: 35))
                    .asForeground(.appBlackAndWhite)
                    .padding(.leading)
                
                TitleTextField(placeholder: Text("제목을 입력하세요").font(Font.customFont(name: CustomFont.gyuri, size: 20)).foregroundColor(.gray), text: $viewModel.output.title)
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
                    Text(viewModel.output.isSkipTitle ? "제목 입력하기" : "제목 입력하지 않기")
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
                    Text("수정")
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
