//
//  ResourceFonts.swift
//  TellMeDay
//
//  Created by 전준영 on 9/22/24.
//

import UIKit
import SwiftUI

struct CustomFont {
    static let gyuri = "NanumGyuRiEuiIrGi"
}

enum CustomUIFont {
    case regular(CGFloat)
    case bold(CGFloat)
    case custom(String, CGFloat)
    
    func font() -> UIFont {
        switch self {
        case .regular(let size):
            return UIFont.systemFont(ofSize: size)
        case .bold(let size):
            return UIFont.boldSystemFont(ofSize: size)
        case .custom(let fontName, let size):
            return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
}

extension CustomUIFont {
    static let regular13 = CustomUIFont.regular(13).font()
    static let regular14 = CustomUIFont.regular(14).font()
    static let regular15 = CustomUIFont.regular(15).font()
    static let regular16 = CustomUIFont.regular(16).font()
    static let regular17 = CustomUIFont.regular(17).font()
    
    static let bold13 = CustomUIFont.bold(13).font()
    static let bold14 = CustomUIFont.bold(14).font()
    static let bold15 = CustomUIFont.bold(15).font()
    static let bold16 = CustomUIFont.bold(16).font()
    
    static let bold25 = CustomUIFont.bold(25).font()
}


extension Font {
    static func customFont(name: String, size: CGFloat) -> Font {
        return Font(UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size))
    }
}

