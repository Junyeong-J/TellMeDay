//
//  MainView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/10/24.
//

import SwiftUI

struct MainView: View {
    
    @State private var selectedDate: Date? = nil
    
    var body: some View {
        
        NavigationStack {
            VStack {
                MonthCalendarViewControllerWrapper(selectedDate: $selectedDate)
                    .frame(height: 450)
                    .padding()
            }
            
            .navigationDestination(isPresented: Binding(
                get: { selectedDate != nil },
                set: { _ in selectedDate = nil }
            )) {
                if let date = selectedDate {
                    RecodeView()
                }
            }
        }
        
    }
}

#Preview {
    MainView()
}
