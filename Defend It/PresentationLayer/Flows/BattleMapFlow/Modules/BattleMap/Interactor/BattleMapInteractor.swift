// 
//  BattleMapInteractor.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import Foundation

class BattleMapInteractor: BattleMapInteractorInput {
    
    weak var output: BattleMapInteractorOutput!
    
    func battleIconPressed(byId id: Int) {
        guard let battleMission = BattleMissions(rawValue: id) else {return}
        CurrentBattleImp.shared.choseBattle(battleMission: battleMission)
    }
}
