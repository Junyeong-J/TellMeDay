//
//  RecodeView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/18/24.
//

import SwiftUI

struct RecodeView: View {
    var selectedDate: Date

    var body: some View {
        VStack {
            Text("Recording View for \(selectedDate, formatter: dateFormatter)")
                .font(.largeTitle)
                .padding()
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
}
