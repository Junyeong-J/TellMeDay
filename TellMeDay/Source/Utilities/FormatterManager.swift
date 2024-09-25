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
}
