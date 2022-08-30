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
    var battleValues: EconomicBattleValues! {get}
}

class BattleManagerImpl: BattleManager {
    var battleValues: EconomicBattleValues!
    
    weak var delegate: BattleManagerDelegate!
    
    init(battleValues: EconomicBattleValues) {
        self.battleValues = battleValues
    }
    
    func areLivesOver() -> Bool {
        battleValues.get(.lives) <= 0
    }
}

