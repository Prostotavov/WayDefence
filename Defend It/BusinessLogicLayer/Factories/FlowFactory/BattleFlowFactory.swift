//
//  BattleFlowFactory.swift
//  Defend It
//
//  Created by Роман Сенкевич on 25.07.22.
//

import Foundation

protocol BattleFlowFactory {
    
    func produceLoadBattleOutput() -> LoadBattleViewCoordinatorOutput
    func produceBattleFieldOutput() -> BattleFieldViewCoordinatorOutput
    func produceLoseBattleOutput() -> LoseBattleViewCoordinatorOutput
    func produceWinBattleOutput() -> WinBattleViewCoordinatorOutput

}
