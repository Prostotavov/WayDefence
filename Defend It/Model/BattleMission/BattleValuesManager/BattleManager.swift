//
//  BattleValuesManager.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.05.22.
//

import Foundation

protocol BattleManagerDelegate: AnyObject {
    func livesAreOver()
}

protocol BattleManager {
    var battleValues: BattleMissionValues! {get}
}

class BattleManagerImpl: BattleManager {
    var battleValues: BattleMissionValues!
    
    weak var delegate: BattleManagerDelegate!
    
    init(battleValues: BattleMissionValues) {
        self.battleValues = battleValues
    }
    
    func areLivesOver() -> Bool {
        battleValues.economicBattleValues.get(.lives) <= 0
    }
}

