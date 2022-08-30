//
//  BattleMissionsValuesData.swift
//  Defend It
//
//  Created by Роман Сенкевич on 13.08.22.
//

import Foundation

struct BattleMissionsValuesData {
    
    static let shared = BattleMissionsValuesData()
    
    func getMeadowForBattle(id: BattleMissions) -> EconomicBattleValues {
        switch id {
        case .first:
            return getValuesForBattle01()
        case .second:
            return getValuesForBattle02()
        case .third:
            return getValuesForBattle03()
        case .four:
            return getValuesForBattle04()
        case .five:
            return getValuesForBattle05()
        }
    }
}

private extension BattleMissionsValuesData {
    func getValuesForBattle01() -> EconomicBattleValues {
        EconomicBattleValuesImp(coins: 1500, points: 0, lives: 100)
    }
    
    func getValuesForBattle02() -> EconomicBattleValues {
        EconomicBattleValuesImp(coins: 750, points: 0, lives: 20)
    }
    
    func getValuesForBattle03() -> EconomicBattleValues {
        EconomicBattleValuesImp(coins: 350, points: 0, lives: 30)
    }
    
    func getValuesForBattle04() -> EconomicBattleValues {
        EconomicBattleValuesImp(coins: 450, points: 0, lives: 40)
    }
    
    func getValuesForBattle05() -> EconomicBattleValues {
        EconomicBattleValuesImp(coins: 550, points: 0, lives: 50)
    }
}
