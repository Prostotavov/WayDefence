//
//  BattleFieldViewCoordinatorOutput.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import Foundation

protocol BattleFieldViewCoordinatorOutput: Presentable {
    
    var onFinishBattle: (() -> Void)? { get set }
    var onWinBattle: (() -> Void)? { get set }
    var onLoseBattle: (() -> Void)? { get set }
}
