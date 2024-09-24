//
//  RecodeView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/18/24.
//

import SwiftUI

struct RecodeView: View {
    
    let selectedDate: Date
    
    @State private var title: String = ""
    @State private var selectedCategory: String = "카테고리 선택"
    let categories = ["일상생활", "영화", "여행", "기타"]
    @State private var customCategory: String = ""
    @State private var skipTitle: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                
                Text(formattedDate(selectedDate))
                    .font(Font.customFont(name: CustomFont.gyuri, size: 25))
                    .asForeground(.black)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            
            HStack() {
                Text("카테고리")
                    .font(Font.customFont(name: CustomFont.gyuri, size: 35))
                    .asForeground(.black)
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
                        .asForeground(.black)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                }
                .padding(.leading)
                
                Spacer()
            }
            .padding(.leading, 16)
            
            if selectedCategory == "기타" {
                TitleTextField(placeholder: Text("카테고리 입력하기").font(Font.customFont(name: CustomFont.gyuri, size: 20)).foregroundColor(.gray), text: $customCategory)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    .padding(.horizontal)
            }
            
            VStack(alignment: .leading) {
                Text("제목")
                    .font(Font.customFont(name: CustomFont.gyuri, size: 35))
                    .asForeground(.black)
                    .padding(.leading)
                
                TitleTextField(placeholder: Text("제목을 입력하세요").font(Font.customFont(name: CustomFont.gyuri, size: 20)).foregroundColor(.gray), text: $title)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    .padding(.horizontal)
                
                Button(action: {
                    skipTitle.toggle()
                    title = skipTitle ? "제목 없음" : ""
                }) {
                    Text("제목 입력하지 않기")
                        .font(Font.customFont(name: CustomFont.gyuri, size: 20))
                        .asForeground(.gray)
                        .padding(.horizontal)
                }
            }
            .padding()
            
            Spacer()
        }
        .padding(.top)
        .background(LinearGradient(gradient: Gradient(colors: [Color(.systemBlue).opacity(0.1), Color(.systemGray6)]), startPoint: .top, endPoint: .bottom))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: VoiceDiaryRecordingView()) {
                    Image(systemName: "arrowshape.right.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                }
            }
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
}

struct RecodeView_Previews: PreviewProvider {
    static var previews: some View {
        RecodeView(selectedDate: Date())
    }
}

