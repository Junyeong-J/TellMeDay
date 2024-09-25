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
    
    func fetchArtwork(_ date: Date, completion: @escaping (UIImage?) -> Void) {
        let imageURL = UIImage(systemName: "star")?.withTintColor(.appMain, renderingMode: .alwaysOriginal)
        completion(imageURL)
    }
    
    func isCurrentSelected(_ date: Date) -> Bool {
        return date == currentSelectedDate
    }
    
    func updateSelectedDate(_ date: Date) {
        previousSelectedDate = currentSelectedDate
        currentSelectedDate = date
    }
}
