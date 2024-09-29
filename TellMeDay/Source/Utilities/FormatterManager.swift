//
//  FormatterManager.swift
//  TellMeDay
//
//  Created by 전준영 on 9/25/24.
//

import Foundation

final class FormatterManager {
    
    static let shared = FormatterManager()
    
    private init() { }
    
    private let formatter = DateFormatter()
    
    func dateFormatter() -> DateFormatter {
        formatter.dateFormat = "MMMM"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
    
    func mainViewDateHeader() -> DateFormatter {
        formatter.dateFormat = "yyyy.MM.dd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
    
    func recodingDateHeader(_ date: Date) -> String {
        formatter.dateFormat = "yyyy.MM.dd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    func formattedDate(_ date: Date) -> String {
        formatter.dateFormat = "yyyy년 M월"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    func updateDateRangeText() -> String {
        let calendar = Calendar.current
        formatter.dateFormat = "yyyy.MM.dd"
        
        let currentDate = Date()
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        
        var components = DateComponents()
        components.month = 1
        components.day = -1
        let endOfMonth = calendar.date(byAdding: components, to: startOfMonth)!
        
        let startDateString = formatter.string(from: startOfMonth)
        let endDateString = formatter.string(from: endOfMonth)
        
        return "\(startDateString) - \(endDateString)"
    }
}
