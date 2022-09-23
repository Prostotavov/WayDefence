//
//  GameSettings.swift
//  Defend It
//
//  Created by Роман Сенкевич on 21.09.22.
//

import Foundation

struct GameSettings {
    
    static var shared = GameSettings()
    
    var battleSettings: BattleSettings
    
    init() {
        battleSettings = BattleSettings()
    }
}
