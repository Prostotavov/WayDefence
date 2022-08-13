//
//  BattleMissionsValuesData.swift
//  Defend It
//
//  Created by Роман Сенкевич on 13.08.22.
//

import Foundation

struct BattleMissionsValuesData {
    
    static let shared = BattleMissionsValuesData()
    
    func getValuesForBattle01() -> BattleMissionValues {
        BattleMissionValues( 
        economicBattleValues: EconomicBattleValuesImp(coins: 1500, points: 0, lives: 100),
        economicAccountReward: EconomicAccountValuesImp(coins: 100, points: 150, gems: 10))
    }
    
    func getValuesForBattle02() -> BattleMissionValues {
        BattleMissionValues(
        economicBattleValues: EconomicBattleValuesImp(coins: 750, points: 0, lives: 20),
        economicAccountReward: EconomicAccountValuesImp(coins: 100, points: 150, gems: 10))
    }
    
    func getValuesForBattle03() -> BattleMissionValues {
        BattleMissionValues(
        economicBattleValues: EconomicBattleValuesImp(coins: 350, points: 0, lives: 30),
        economicAccountReward: EconomicAccountValuesImp(coins: 100, points: 150, gems: 10))
    }
    
    func getValuesForBattle04() -> BattleMissionValues {
        BattleMissionValues(
        economicBattleValues: EconomicBattleValuesImp(coins: 450, points: 0, lives: 40),
        economicAccountReward: EconomicAccountValuesImp(coins: 100, points: 150, gems: 10))
    }
    
    func getValuesForBattle05() -> BattleMissionValues {
        BattleMissionValues(
        economicBattleValues: EconomicBattleValuesImp(coins: 550, points: 0, lives: 50),
        economicAccountReward: EconomicAccountValuesImp(coins: 100, points: 150, gems: 10))
    }
}
