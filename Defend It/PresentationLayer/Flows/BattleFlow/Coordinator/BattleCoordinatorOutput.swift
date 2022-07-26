//
//  BattleCoordinatorOutput.swift
//  Defend It
//
//  Created by Роман Сенкевич on 25.07.22.
//

import Foundation

protocol BattleCoordinatorOutput: AnyObject {
    
    var finishFlow: (() -> Void)? { get set }
}
