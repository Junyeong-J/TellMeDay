//
//  EmotionImageManager.swift
//  TellMeDay
//
//  Created by 전준영 on 9/28/24.
//

import SwiftUI

struct EmotionImageManager {
    static func image(for emotion: String) -> Image {
        switch emotion {
        case "기쁨":
            return Image("happyEmoji")
        case "슬픔":
            return Image(systemName: "moon.fill")
        case "공포":
            return Image(systemName: "exclamationmark.triangle.fill")
        case "분노":
            return Image(systemName: "flame.fill")
        default:
            return Image(systemName: "questionmark.circle.fill")
        }
    }
}
