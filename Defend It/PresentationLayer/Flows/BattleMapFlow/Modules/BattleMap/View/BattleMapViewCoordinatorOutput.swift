// 
//  BattleMapViewCoordinatorOutput.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import Foundation

protocol BattleMapViewCoordinatorOutput: Presentable {
    var onBattleIcon: (() -> Void)? { get set }
}
