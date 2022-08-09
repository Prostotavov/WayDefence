//
//  GameAccount.swift
//  Defend It
//
//  Created by Роман Сенкевич on 5.08.22.
//

import Foundation

protocol GameAccount: AnyObject {
    func increase(_ valueType: GameAccountValueTypes, by value: Int)
    func reduce(_ valueType: GameAccountValueTypes, by value: Int)
    func set(_ valueType: GameAccountValueTypes, to newValue: Int)
    func get(_ valueType: GameAccountValueTypes) -> Int
}

class GameAccountImp: GameAccount {
    private var gameAccountValues: GameAccountValues?
    
    init() {
        gameAccountValues = GameAccountValuesImp()
    }
}

// funcs from class GameAccountValues
extension GameAccountImp {
    func increase(_ valueType: GameAccountValueTypes, by value: Int) {
        gameAccountValues?.increase(valueType, by: value)
    }
    
    func reduce(_ valueType: GameAccountValueTypes, by value: Int) {
        gameAccountValues?.reduce(valueType, by: value)
    }
    
    func set(_ valueType: GameAccountValueTypes, to newValue: Int) {
        gameAccountValues?.set(valueType, to: newValue)
    }
    
    func get(_ valueType: GameAccountValueTypes) -> Int {
        if gameAccountValues == nil {return 0}
        return gameAccountValues!.get(valueType)
    }
}
