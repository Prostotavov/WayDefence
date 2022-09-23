//
//  BattleSettings.swift
//  Defend It
//
//  Created by Роман Сенкевич on 21.09.22.
//

import Foundation

enum TouchingScreenParts {
    case topОfTheScreen
    case bottomОfTheScreen
    case touchPlace
    
    mutating func toggleBetweenParts() {
        switch self {
        case .topОfTheScreen:
            self = .bottomОfTheScreen
        case .bottomОfTheScreen:
            self = .touchPlace
        case .touchPlace:
            self = .topОfTheScreen
        }
    }
}

struct BattleSettings {
    
    var isHalfScreenModeActive = false
    var touchingScreenPart: TouchingScreenParts = .touchPlace
    var raiseTouchFactor = 0.1
    var lowerTouchFactor = 0.12
}
