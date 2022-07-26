//
//  BattleValues.swift
//  Defend It
//
//  Created by Роман Сенкевич on 10.07.22.
//

import Foundation

enum BattleValueTypes {
    case coins
    case lives
    case points
}

protocol BattleValues {
    func increase(_ value: BattleValueTypes, by number: Int)
    func reduce(_ value: BattleValueTypes, by number: Int)
    func set(_ value: BattleValueTypes, to number: Int)
    func get(_ value: BattleValueTypes) -> Int
}

class BattleValuesImpl: BattleValues {
    private var coins: Int = 0
    private var points: Int = 0
    private var lives: Int = 0
    
    func increase(_ value: BattleValueTypes, by number: Int) {
        switch value {
        case .coins: coins += number
        case .lives: lives += number
        case .points: points += number
        }
    }
    
    func reduce(_ value: BattleValueTypes, by number: Int) {
        switch value {
        case .coins: coins -= number
        case .lives: lives -= number
        case .points: points -= number
        }
    }
    
    func set(_ value: BattleValueTypes, to number: Int) {
        switch value {
        case .coins: coins = number
        case .lives: lives = number
        case .points: points = number
        }
    }
    
    func get(_ value: BattleValueTypes) -> Int {
        switch value {
        case .coins: return coins
        case .lives: return lives
        case .points: return points
        }
    }
}
