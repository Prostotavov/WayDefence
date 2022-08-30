//
//  EconomicBattleValues.swift
//  Defend It
//
//  Created by Роман Сенкевич on 10.07.22.
//

import Foundation

enum EconomicBattleValueTypes {
    case coins
    case lives
    case points
}

protocol EconomicBattleValues {
    func increase(_ value: EconomicBattleValueTypes, by number: Int)
    func reduce(_ value: EconomicBattleValueTypes, by number: Int)
    func set(_ value: EconomicBattleValueTypes, to number: Int)
    func get(_ value: EconomicBattleValueTypes) -> Int
}

class EconomicBattleValuesImp: EconomicBattleValues {

    private var coins: Int?
    private var points: Int?
    private var lives: Int?
    
    init() {
        coins = 0
        points = 0
        lives = 0
    }
    
    // set start values for every account
    init(coins: Int, points: Int, lives: Int) {
        self.coins = coins
        self.points = points
        self.lives = lives
    }
}

// realization get func
extension EconomicBattleValuesImp {
    func get(_ valueType: EconomicBattleValueTypes) -> Int {
        switch valueType {
        case .coins: return getCoins()
        case .lives: return getLives()
        case .points: return getPoints()
        }
    }
    
    private func getCoins() -> Int {
        if self.coins == nil {return 0}
        return self.coins!
    }
    
    private func getLives() -> Int {
        if self.lives == nil {return 0}
        return self.lives!
    }
    
    private func getPoints() -> Int {
        if self.points == nil {return 0}
        return self.points!
    }
}

// realization set func
extension EconomicBattleValuesImp {
    func set(_ valueType: EconomicBattleValueTypes, to newValue: Int) {
        switch valueType {
        case .coins: setCoins(to: newValue)
        case .lives: setLives(to: newValue)
        case .points: setPoints(to: newValue)
        }
    }
    
    private func setCoins(to newValue: Int) {
        self.coins = newValue
    }
    
    private func setLives(to newValue: Int) {
        self.lives = newValue
    }
    
    private func setPoints(to newValue: Int) {
        self.points = newValue
    }
}

// realization reduce func
extension EconomicBattleValuesImp {
    func reduce(_ valueType: EconomicBattleValueTypes, by value: Int) {
        switch valueType {
        case .coins: reduceCoins(by: value)
        case .lives: reduceLives(by: value)
        case .points: reducePoints(by: value)
        }
    }
    
    private func reduceCoins(by value: Int) {
        (coins == nil) ? (coins = value) : (coins! -= value)
    }
    
    private func reduceLives(by value: Int) {
        (lives == nil) ? (lives = value) : (lives! -= value)
    }
    
    private func reducePoints(by value: Int) {
        (points == nil) ? (points = value) : (points! -= value)
    }
}

// realization increase func
extension EconomicBattleValuesImp {
    func increase(_ valueType: EconomicBattleValueTypes, by value: Int) {
        switch valueType {
        case .coins: increaseCoins(by: value)
        case .lives: increaseLives(by: value)
        case .points: increasePoints(by: value)
        }
    }
    
    private func increaseCoins(by value: Int) {
        (coins == nil) ? (coins = value) : (coins! += value)
    }
    
    private func increaseLives(by value: Int) {
        (lives == nil) ? (lives = value) : (lives! += value)
    }
    
    private func increasePoints(by value: Int) {
        (points == nil) ? (points = value) : (points! += value)
    }
}
