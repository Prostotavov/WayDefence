//
//  EconomicAccountValues.swift
//  Defend It
//
//  Created by Роман Сенкевич on 5.08.22.
//

import Foundation

import Foundation

protocol EconomicAccountValues {
    func increase(_ valueType: EconomicAccountValueTypes, by value: Int)
    func reduce(_ valueType: EconomicAccountValueTypes, by value: Int)
    func set(_ valueType: EconomicAccountValueTypes, to newValue: Int)
    func get(_ valueType: EconomicAccountValueTypes) -> Int

}

class EconomicAccountValuesImp: EconomicAccountValues {
        
    private var coins: Int?
    private var points: Int?
    private var gems: Int?
    
    init() {
        coins = 0
        points = 0
        gems = 0
    }
    
    // set start values for every account
    init(coins: Int, points: Int, gems: Int) {
        self.coins = coins
        self.points = points
        self.gems = gems
    }
}

// realization get func
extension EconomicAccountValuesImp {
    func get(_ valueType: EconomicAccountValueTypes) -> Int {
        switch valueType {
        case .coins: return getCoins()
        case .gems: return getGems()
        case .points: return getPoints()
        }
    }
    
    private func getCoins() -> Int {
        if self.coins == nil {return 0}
        return self.coins!
    }
    
    private func getGems() -> Int {
        if self.gems == nil {return 0}
        return self.gems!
    }
    
    private func getPoints() -> Int {
        if self.points == nil {return 0}
        return self.points!
    }
}

// realization set func
extension EconomicAccountValuesImp {
    func set(_ valueType: EconomicAccountValueTypes, to newValue: Int) {
        switch valueType {
        case .coins: setCoins(to: newValue)
        case .gems: setGems(to: newValue)
        case .points: setPoints(to: newValue)
        }
    }
    
    private func setCoins(to newValue: Int) {
        self.coins = newValue
    }
    
    private func setGems(to newValue: Int) {
        self.gems = newValue
    }
    
    private func setPoints(to newValue: Int) {
        self.points = newValue
    }
}

// realization reduce func
extension EconomicAccountValuesImp {
    func reduce(_ valueType: EconomicAccountValueTypes, by value: Int) {
        switch valueType {
        case .coins: reduceCoins(by: value)
        case .gems: reduceGems(by: value)
        case .points: reducePoints(by: value)
        }
    }
    
    private func reduceCoins(by value: Int) {
        (coins == nil) ? (coins = value) : (coins! -= value)
    }
    
    private func reduceGems(by value: Int) {
        (gems == nil) ? (gems = value) : (gems! -= value)
    }
    
    private func reducePoints(by value: Int) {
        (points == nil) ? (points = value) : (points! -= value)
    }
}

// realization increase func
extension EconomicAccountValuesImp {
    func increase(_ valueType: EconomicAccountValueTypes, by value: Int) {
        switch valueType {
        case .coins: increaseCoins(by: value)
        case .gems: increaseGems(by: value)
        case .points: increasePoints(by: value)
        }
    }
    
    private func increaseCoins(by value: Int) {
        (coins == nil) ? (coins = value) : (coins! += value)
    }
    
    private func increaseGems(by value: Int) {
        (gems == nil) ? (gems = value) : (gems! += value)
    }
    
    private func increasePoints(by value: Int) {
        (points == nil) ? (points = value) : (points! += value)
    }
}
