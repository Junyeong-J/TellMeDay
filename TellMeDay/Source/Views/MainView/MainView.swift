//
//  MainView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/10/24.
//

import SwiftUI

struct MainView: View {
    @State var firstNaviLinkActive = false
    @State private var selectedDate: Date? = nil
    
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
        if let date = selectedDate {
            RecodingView(selectedDate: date, firstNaviLinkActive: $firstNaviLinkActive)
        } else {
            EmptyView() // 선택된 날짜가 없을 경우 빈 화면
        }
    }
}


#Preview {
    MainView()
}
