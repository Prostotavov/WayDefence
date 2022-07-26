// 
//  PauseBattleViewCoordinatorOutput.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import Foundation

protocol PauseBattleViewCoordinatorOutput: Presentable {
    var onPlay: (() -> Void)? { get set }
    var onQuit: (() -> Void)? { get set }
}
