//
//  MainView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/10/24.
//

import SwiftUI

struct MainView: View {
    
    @Binding var hideTabBar: Bool
    @State var firstNaviLinkActive = false
    @State private var selectedDate: Date? = nil
    private let repository = ListTableRepository()
    
    var body: some View {
        NavigationView {
            VStack {
                MonthCalendarViewControllerWrapper(selectedDate: $selectedDate, firstNaviLinkActive: $firstNaviLinkActive)
                    .frame(height: 450)
                    .padding(.top)
                    .padding(.horizontal)
                
                Spacer()
            }
            .background(Color.appBaseBackground)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .onChange(of: firstNaviLinkActive) { newValue in
                hideTabBar = newValue
            }
        }
        .edgesIgnoringSafeArea(.all)
        .overlay(
            NavigationLink(destination: destinationView(), isActive: $firstNaviLinkActive) {
                EmptyView()
            }
        )
    }
    
    @ViewBuilder
    func destinationView() -> some View {
        if let date = selectedDate, let entry = repository.fetchEntryTo(for: date) {
            DiaryDetailView(entry: entry, firstNaviLinkActive: $firstNaviLinkActive, hideDiaryTabBar: .constant(false))
        } else if let date = selectedDate {
            RecodingView(selectedDate: date, firstNaviLinkActive: $firstNaviLinkActive, hideTabBar: $hideTabBar)
        } else {
            EmptyView()
        }
    }

}


//#Preview {
//    MainView()
//}
