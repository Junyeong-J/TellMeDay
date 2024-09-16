//
//  CalendarViewModel.swift
//  TellMeDay
//
//  Created by 전준영 on 9/16/24.
//

import Foundation

final class CalendarViewModel {
    
    // 선택된 날짜를 추적하는 변수
    var currentSelectedDate: Date? = nil
    var previousSelectedDate: Date? = nil
    
    // 예시로 사용되는 이미지 URL을 가져오는 메소드
    func fetchArtwork(_ date: Date, completion: @escaping (URL?) -> Void) {
        // 예를 들어, 날짜에 따른 URL을 결정
        let imageURL = URL(string: "https://example.com/image.png") // URL 예시
        completion(imageURL)
    }
    
    // 선택된 날짜가 현재 선택된 날짜인지 확인
    func isCurrentSelected(_ date: Date) -> Bool {
        return date == currentSelectedDate
    }
    
    // 선택된 날짜 업데이트
    func updateSelectedDate(_ date: Date) {
        previousSelectedDate = currentSelectedDate
        currentSelectedDate = date
    }
}
