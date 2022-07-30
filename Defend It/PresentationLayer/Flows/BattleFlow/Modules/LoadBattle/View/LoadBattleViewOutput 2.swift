//
//  LoadBattleViewOutput.swift
//  Defend It
//
//  Created by Роман Сенкевич on 25.07.22.
//

import Foundation

protocol LoadBattleViewCoordinatorOutput: Presentable {
    
    var onAccept: (() -> Void)? { get set }
}
