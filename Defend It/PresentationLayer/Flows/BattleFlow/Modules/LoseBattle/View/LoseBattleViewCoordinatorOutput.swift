// 
//  LoseBattleViewCoordinatorOutput.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import Foundation

protocol LoseBattleViewCoordinatorOutput: Presentable {
    var onAccept: (() -> Void)? { get set }
}
