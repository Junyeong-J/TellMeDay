//
//  MyDiaryView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/29/24.
//

import SwiftUI

struct MyDiaryView: View {
    
    @State private var currentDate = Date()
    @State private var diaryEntries: [DiaryEntry] = []
    @State var firstNaviLinkActive = false
    @Binding var hideDiaryTabBar: Bool
    var repository = ListTableRepository()
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    VStack {
                        HStack {
                            Spacer()
                            
                            ZStack {
                                Rectangle()
                                    .frame(width: geometry.size.width * 0.5, height: 40)
                                    .opacity(0)
                                
                                HStack {
                                    Button(action: {
                                        changeMonth(by: -1)
                                    }) {
                                        Image(systemName: "chevron.left.circle")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .asForeground(.appBlackAndWhite)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(FormatterManager.shared.formattedDate(currentDate))
                                        .font(Font.customFont(name: CustomFont.gyuri, size: 30))
                                        .asForeground(.appGrayAndWhite)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        changeMonth(by: 1)
                                    }) {
                                        Image(systemName: "chevron.right.circle")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .asForeground(.appBlackAndWhite)
                                    }
                                }
                                .frame(width: geometry.size.width * 0.5)
                            }
                            
                            Spacer()
                        }
                        .padding(.top, 20)
                    }
                }
                .frame(height: 60)
                
                Spacer()
                
                ScrollView {
                    VStack(spacing: 16) {
                        if diaryEntries.isEmpty {
                            Text(StringData.MyDiary.noEntryMessage)
                                .font(Font.customFont(name: CustomFont.gyuri, size: 20))
                                .asForeground(.appGrayAndWhite)
                                .padding(.top, 60)
                                .multilineTextAlignment(.center)
                        } else {
                            ForEach(diaryEntries, id: \.id) { entry in
                                NavigationLink(
                                    destination: DiaryDetailView(entry: entry, firstNaviLinkActive: $firstNaviLinkActive, hideDiaryTabBar: $hideDiaryTabBar)
                                        .onAppear { hideDiaryTabBar = true }
                                ) {
                                    DiaryCardView(entry: entry)
                                }
                            }
                        }
                    }
                    .padding()
                    .padding(.bottom, 100)
                }
            }
            .background(Color(.appBaseBackground))
            .onAppear {
                loadEntries(for: currentDate)
            }
            .onChange(of: firstNaviLinkActive) { newValue in
                hideDiaryTabBar = newValue
            }
        }
    }
    
    func changeMonth(by months: Int) {
        if let newDate = Calendar.current.date(byAdding: .month, value: months, to: currentDate) {
            currentDate = newDate
            loadEntries(for: newDate)
        }
    }
    
    func loadEntries(for date: Date) {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        
        diaryEntries = repository.fetchEntries(for: year, month: month)
    }
}

