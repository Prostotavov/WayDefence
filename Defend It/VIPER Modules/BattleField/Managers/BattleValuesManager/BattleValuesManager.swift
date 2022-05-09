//
//  BattleValuesManager.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.05.22.
//

import Foundation

protocol BattleValuesManager {
    func increase(_ value: BattleValues, by number: Int)
    func reduce(_ value: BattleValues, by number: Int)
    func set(_ value: BattleValues, to number: Int)
    func get(_ value: BattleValues) -> Int
}

class BattleValuesManagerImpl: BattleValuesManager {
    private var coins: Int = 320
    private var lives: Int = 10
    private var points: Int = 0
    
    func increase(_ value: BattleValues, by number: Int) {
        switch value {
        case .coins: coins += number
        case .lives: lives += number
        case .points: points += number
        }
    }
    
    func reduce(_ value: BattleValues, by number: Int) {
        switch value {
        case .coins: coins -= number
        case .lives: lives -= number
        case .points: points -= number
        }
    }
    
    func set(_ value: BattleValues, to number: Int) {
        switch value {
        case .coins: coins = number
        case .lives: lives = number
        case .points: points = number
        }
    }
    
    func get(_ value: BattleValues) -> Int {
        switch value {
        case .coins: return coins
        case .lives: return lives
        case .points: return points 
        }
    }
}

enum BattleValues {
    case coins
    case lives
    case points
}
