//
//  VoiceDiaryRecordingView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/24/24.
//

import SwiftUI

struct VoiceDiaryRecordingView: View {
    
    @StateObject private var viewModel = VoiceDiaryRecordingViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                    
                    Text(viewModel.output.selectedDate)
                        .font(Font.customFont(name: CustomFont.gyuri, size: 25))
                        .asForeground(.black)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                    
                   
                }
                Spacer()
                
            }
            .onAppear {
//                viewModel.input.selectedDate.send(Date())
            }
        }
    }
}

#Preview {
    VoiceDiaryRecordingView()
}
