//
//  ButtonImage.swift
//  wordle-ios
//
//  Created by Josep Bordes 2 on 12/2/22.
//

import Foundation

enum ButtonImage {
    case back
    case check
    case close
    case delete
    case play
    case select
    case settings
    case generic(String)
    case questionMarkblue
    
    var imageName: String {
        switch self {
        case .back: return "back_btn"
        case .check: return "check_btn"
        case .close: return "close_btn"
        case .delete: return "delete_btn"
        case .play: return "play_btn"
        case .select: return "select_btn"
        case .settings: return "settings_btn"
        case .generic: return "list_img"
        case .questionMarkblue: return "question_blue_btn"
        }
    }
}
