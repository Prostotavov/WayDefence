//
//  CurrentBattle.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.07.22.
//

import Foundation

protocol CurrentBattle {
    var chosenBattleMission: BattleMissions {get}
    func choseBattle(battleMission: BattleMissions)
}

class CurrentBattleImp: CurrentBattle {
    
    var chosenBattleMission: BattleMissions = .first
    
    static let shared = CurrentBattleImp()
    
    func choseBattle(battleMission: BattleMissions) {
        chosenBattleMission = battleMission
    }
}
