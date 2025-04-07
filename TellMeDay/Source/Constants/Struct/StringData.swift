//
//  StringData.swift
//  TellMeDay
//
//  Created by 전준영 on 4/7/25.
//

import Foundation

struct StringData {
    
    struct Common {
        static let title = NSLocalizedString("제목", comment: "")
        static let enterTitle = NSLocalizedString("제목을 입력하세요", comment: "")
        static let skipTitle = NSLocalizedString("제목 입력하지 않기", comment: "")
        static let writeTitle = NSLocalizedString("제목 입력하기", comment: "")
        static let categoryInput = NSLocalizedString("카테고리 입력하기", comment: "")
        static let categorySelect = NSLocalizedString("카테고리 선택", comment: "")
        static let modify = NSLocalizedString("수정", comment: "")
    }
    
    struct Category {
        static let everyday = NSLocalizedString("일상생활", comment: "")
        static let movie = NSLocalizedString("영화", comment: "")
        static let travel = NSLocalizedString("여행", comment: "")
        static let etc = NSLocalizedString("기타", comment: "")
        
        static var all: [String] {
            [everyday, movie, travel, etc]
        }
    }
    
    struct AnalysisResult {
        static let title = NSLocalizedString("감정 분석 결과", comment: "")
        static let todayEmotion = NSLocalizedString("오늘의 기분입니다", comment: "")
        static let goToMain = NSLocalizedString("메인 페이지로 가기", comment: "")
        static let positive = NSLocalizedString("긍정", comment: "")
        static let negative = NSLocalizedString("부정", comment: "")
    }
    
    struct VoiceDiary {
        static let maxRecordingInfo = NSLocalizedString("최대 녹음 시간 안내", comment: "")
        static let saveAndAnalyze = NSLocalizedString("저장 및 분석", comment: "")
        static let micPermissionDeniedTitle = NSLocalizedString("마이크 권한 거부됨", comment: "")
        static let micPermissionDeniedMessage = NSLocalizedString("마이크에 대한 엑세스 권한이 거부되었습니다. 권한을 변경하시겠습니까?", comment: "")
        static let goToSettings = NSLocalizedString("설정으로 이동", comment: "")
        static let cancel = NSLocalizedString("취소", comment: "")
    }
    
    struct MyDiary {
        static let noEntryMessage = NSLocalizedString("작성한 일기가 없습니다", comment: "")
    }
    
    struct DiaryDetail {
        static let noCategory = NSLocalizedString("카테고리 없음", comment: "")
        static let noContent = NSLocalizedString("내용 없음", comment: "")
        static let deleteTitle = NSLocalizedString("일기를 삭제하시겠습니까?", comment: "")
        static let deleteMessage = NSLocalizedString("삭제된 일기는 복구할 수 없습니다.", comment: "")
        static let deleteConfirm = NSLocalizedString("삭제", comment: "")
        static let cancel = NSLocalizedString("취소", comment: "")
    }
    
    struct Analyze {
        static let description = NSLocalizedString("감정 분석 나무 설명", comment: "")
        static let savedRange = NSLocalizedString("저장소에 넣어둔 기간", comment: "")
    }
    
    struct Emotion {
        static let joyKey = "joy"
        static let sadnessKey = "sadness"
        static let angerKey = "anger"
        static let fearKey = "fear"

        static let joy = NSLocalizedString("기쁨", comment: "")
        static let sadness = NSLocalizedString("슬픔", comment: "")
        static let anger = NSLocalizedString("분노", comment: "")
        static let fear = NSLocalizedString("공포", comment: "")

        static func localized(_ key: String) -> String {
            switch key {
            case joyKey: return joy
            case sadnessKey: return sadness
            case angerKey: return anger
            case fearKey: return fear
            default: return key
            }
        }
    }
}
