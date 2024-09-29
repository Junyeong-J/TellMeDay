//
//  CalendarViewModel.swift
//  TellMeDay
//
//  Created by 전준영 on 9/16/24.
//

import UIKit

final class CalendarViewModel {
    
    var currentSelectedDate: Date? = nil
    var previousSelectedDate: Date? = nil
    private let repository = ListTableRepository()
    
    func fetchArtwork(_ date: Date, completion: @escaping (UIImage?) -> Void) {
        if let entry = repository.fetchEntry(for: date) {
            let emotionImage = EmotionImageManager.emojiName(for: entry.emotion ?? "")
            completion(UIImage(named: emotionImage))
        } else {
            completion(nil)
        }
    }
    
    func isCurrentSelected(_ date: Date) -> Bool {
        return date == currentSelectedDate
    }
    
    func updateSelectedDate(_ date: Date) {
        previousSelectedDate = currentSelectedDate
        currentSelectedDate = date
    }
    
    func isRecordedDate(_ date: Date) -> Bool {
        return repository.fetchEntryTo(for: date) != nil
    }
}
