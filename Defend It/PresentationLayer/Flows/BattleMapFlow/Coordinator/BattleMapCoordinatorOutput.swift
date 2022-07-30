//
//  BattleMapCoordinatorOutput.swift
//  Defend It
//
//  Created by Роман Сенкевич on 28.07.22.
//

import Foundation

protocol BattleMapCoordinatorOutput: AnyObject {
    
    var finishFlow: (() -> Void)? { get set }
}
