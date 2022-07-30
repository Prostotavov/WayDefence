//
//  TabbarCoordinatorOutput.swift
//  Defend It
//
//  Created by Роман Сенкевич on 28.07.22.
//

protocol TabbarCoordinatorOutput: AnyObject {
    
    var finishFlow: (() -> Void)? { get set }
    var startMainFlow: (() -> Void)? { get set }
    
    
    var startBattleFlow: (() -> Void)? { get set }
}
