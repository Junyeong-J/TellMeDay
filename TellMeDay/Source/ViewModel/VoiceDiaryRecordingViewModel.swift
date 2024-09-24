//
//  VoiceDiaryRecordingViewModel.swift
//  TellMeDay
//
//  Created by 전준영 on 9/24/24.
//

import Foundation
import Combine

final class VoiceDiaryRecordingViewModel: ViewModelType {
    
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    
    @Published
    var output = Output()
    
    init() {
        transform()
    }
    
}

extension VoiceDiaryRecordingViewModel {
    
    struct Input {
        var selectedDate = Date()
    }
    
    struct Output {
        var selectedDate: String = ""
    }
    
    func transform() {
        output.selectedDate = formattedDate(input.selectedDate)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
        return formatter.string(from: date)
    }
    
}

extension VoiceDiaryRecordingViewModel {
    
    enum Action {
        
    }
    
    func action(_ action: Action) {
        
    }
    
}
