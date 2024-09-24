//
//  VoiceRecordingViewModel.swift
//  TellMeDay
//
//  Created by 전준영 on 9/24/24.
//

import Foundation
import Combine

final class VoiceRecordingViewModel: ViewModelType {
    
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    
    @Published
    var output = Output()
    
    init() {
        transform()
    }
    
}

extension VoiceRecordingViewModel {
    
    struct Input {
        var selectedDate = Date()
    }
    
    struct Output {
        var selectedDate: String = ""
    }
    
    func transform() {
        
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM월 dd일"
        return formatter.string(from: date)
    }
    
}

extension VoiceRecordingViewModel {
    
    enum Action {
        case viewOnTask
    }
    
    func action(_ action: Action) {
        
    }
    
}
