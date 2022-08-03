//
//  CurrentBattle.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.07.22.
//

import Foundation

protocol CurrentBattle {
    var chosenBattleMission: BattleMissions {get}
    var lastAvailableMission: BattleMissions? {get}
    func choseBattle(battleMission: BattleMissions)
    func currentBattlePassed()
}

class CurrentBattleImp: CurrentBattle {
    
    var chosenBattleMission: BattleMissions = .first
    
    var lastAvailableMission: BattleMissions? = .first
    
    static let shared = CurrentBattleImp()
    
    func choseBattle(battleMission: BattleMissions) {
        chosenBattleMission = battleMission
    }
    
    func currentBattlePassed() {
        if lastAvailableMission == chosenBattleMission {
            lastAvailableMission = BattleMissions(rawValue: chosenBattleMission.rawValue + 1)
        }
    }
    
}
