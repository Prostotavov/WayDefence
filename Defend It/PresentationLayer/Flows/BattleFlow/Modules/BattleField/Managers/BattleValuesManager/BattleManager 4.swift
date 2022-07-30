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
    func increase(_ value: BattleValueTypes, by number: Int)
    func reduce(_ value: BattleValueTypes, by number: Int)
    func set(_ value: BattleValueTypes, to number: Int)
    func get(_ value: BattleValueTypes) -> Int
}

class BattleManagerImpl: BattleManager {
    var battleValues: BattleValues!
    
    weak var delegate: BattleManagerDelegate!
    
    init(battleValues: BattleValues) {
        self.battleValues = battleValues
    }
    
    func increase(_ value: BattleValueTypes, by number: Int) {
        battleValues.increase(value, by: number)
    }
    
    func reduce(_ value: BattleValueTypes, by number: Int) {
        battleValues.reduce(value, by: number)
        if areLivesOver() {delegate.livesAreOver()}
    }
    
    func set(_ value: BattleValueTypes, to number: Int) {
        battleValues.set(value, to: number)
    }
    
    func get(_ value: BattleValueTypes) -> Int {
        battleValues.get(value)
    }
    
    func areLivesOver() -> Bool {
        battleValues.get(.lives) <= 0
    }
}

