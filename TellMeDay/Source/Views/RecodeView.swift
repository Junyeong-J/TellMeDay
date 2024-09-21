//
//  RecodeView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/18/24.
//

import SwiftUI

struct RecodeView: View {
    
    @State private var title: String = ""
    @State private var selectedCategory: String = "카테고리 선택"
    let categories = ["일상생활", "영화", "여행", "기타"]
    @State private var customCategory: String = ""
    @State private var skipTitle: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(alignment: .center) {
                Text("카테고리")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .asForeground(.black)
                    .padding(.leading)
                
                Spacer()
                
                Picker("카테고리 선택", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category)
                            .foregroundColor(.black)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                .padding(.trailing)
            }
            .padding()
            if selectedCategory == "기타" {
                TextField("카테고리 입력", text: $customCategory)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    .padding(.horizontal)
            }
            
            VStack(alignment: .leading) {
                Text("제목")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .asForeground(.black)
                    .padding(.leading)
                
                TextField("제목을 입력하세요", text: $title)
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
                        .font(.subheadline)
                        .asForeground(.gray)
                        .padding(.horizontal)
                }
            }
            .padding()
            
            Spacer()
        }
        .padding(.top)
        .background(LinearGradient(gradient: Gradient(colors: [Color(.systemBlue).opacity(0.1), Color(.systemGray6)]), startPoint: .top, endPoint: .bottom))
        .navigationTitle("기록 작성")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: VoiceRecordingView()) {
                    Text("다음")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
    }
}

struct RecodeView_Previews: PreviewProvider {
    static var previews: some View {
        RecodeView()
    }
}

