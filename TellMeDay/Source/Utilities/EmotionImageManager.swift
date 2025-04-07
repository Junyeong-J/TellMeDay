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
        case StringData.Emotion.joyKey:
            return Image("happyEmoji")
        case StringData.Emotion.sadnessKey:
            return Image("sadEmoji")
        case StringData.Emotion.fearKey:
            return Image("panicEmoji")
        case StringData.Emotion.angerKey:
            return Image("angryEmoji")
        default:
            return Image(systemName: "questionmark.circle.fill")
        }
    }
    
    static func emojiName(for emotion: String) -> String {
        switch emotion {
        case StringData.Emotion.joyKey:
            return "happyEmoji"
        case StringData.Emotion.sadnessKey:
            return "sadEmoji"
        case StringData.Emotion.fearKey:
            return "panicEmoji"
        case StringData.Emotion.angerKey:
            return "angryEmoji"
        default:
            return "questionmark.circle.fill"
        }
    }
}
