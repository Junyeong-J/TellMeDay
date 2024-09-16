//
//  MainView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/10/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        MonthCalendarViewControllerWrapper()
            .frame(height: 450)
            .padding()
    }
}

#Preview {
    MainView()
}
