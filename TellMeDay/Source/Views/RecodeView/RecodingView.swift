//
//  RecodingView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/26/24.
//

import SwiftUI

struct RecodingView: View {
    
    let selectedDate: Date
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = RecodingViewModel()
    let categories = ["일상생활", "영화", "여행", "기타"]
    @Binding var firstNaviLinkActive: Bool
    @Binding var hideTabBar: Bool
    
    var body: some View {
        VStack {
            dateHeaderView(dateText: viewModel.output.selectedDate)
            
            categoriesView(selectedCategory: $viewModel.input.selectedCategory, categories: categories)
                .onChange(of: viewModel.input.selectedCategory) { newCategory in
                    viewModel.updateCategory(newCategory)
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
                    viewModel.input.skipButtonTapped.send(())
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
                    hideTabBar = false
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .asForeground(.appBlackAndWhite)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: VoiceDiaryRecordingView(firstNaviLinkActive: $firstNaviLinkActive,
                                                                    selectedDate: selectedDate,
                                                                    title: viewModel.output.title,
                                                                    category: viewModel.output.selectedCategory)) {
                    Image(systemName: "arrowshape.right.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .asForeground(viewModel.output.isActionButtonEnabled ? .appBlackAndWhite : .gray)
                }
                .disabled(!viewModel.output.isActionButtonEnabled)
            }
        }
        .onAppear {
            hideTabBar = true
            viewModel.input.selectedDate = selectedDate
            viewModel.transform()
        }
        .onTapGesture {
            hideKeyboard()
        }
        
    }
    
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
