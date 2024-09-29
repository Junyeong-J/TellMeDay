//
//  EmotionImageManager.swift
//  TellMeDay
//
//  Created by 전준영 on 9/28/24.
//

import SwiftUI

struct EmotionImageManager {
    static func emojiImage(for emotion: String) -> Image {
        switch emotion {
        case "기쁨":
            return Image("happyEmoji")
        case "슬픔":
            return Image("sadEmoji")
        case "공포":
            return Image("panicEmoji")
        case "분노":
            return Image("angryEmoji")
        default:
            return Image(systemName: "questionmark.circle.fill")
        }
    }
    
    static func emojiName(for emotion: String) -> String {
        switch emotion {
        case "기쁨":
            return "happyEmoji"
        case "슬픔":
            return "sadEmoji"
        case "공포":
            return "panicEmoji"
        case "분노":
            return "angryEmoji"
        default:
            return "questionmark.circle.fill"
        }
    }
    
}
