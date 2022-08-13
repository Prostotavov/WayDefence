// 
//  WinBattleInteractor.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import Foundation

class WinBattleInteractor: WinBattleInteractorInput {
    
    weak var output: WinBattleInteractorOutput!
    
    func battlePassed() {
        CurrentBattleImp.shared.currentBattlePassed()
        rewarded()
    }
    
    func rewarded() {
        let reward = BattleMissionsValuesData.shared.getValuesForBattle01().economicAccountReward
        UserImp.shared.gameAccount?.gameAccountValues?.increase(.points, by: reward.get(.points))
        UserImp.shared.gameAccount?.gameAccountValues?.increase(.coins, by: reward.get(.coins))
        UserImp.shared.gameAccount?.gameAccountValues?.increase(.gems, by: reward.get(.gems))
    }
    
}
