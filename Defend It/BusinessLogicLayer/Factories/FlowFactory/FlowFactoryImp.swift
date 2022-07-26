//
//  FlowFactoryImp.swift
//  Defend It
//
//  Created by Роман Сенкевич on 25.07.22.
//

import Foundation

import UIKit.UIViewController

class FlowFactoryImp: BattleFlowFactory {
    
    var vc: LoadBattleViewController!
    
    func produceLoadBattleOutput() -> LoadBattleViewCoordinatorOutput {
        vc = LoadBattleViewController()
        return vc
    }
    
    func produceBattleFieldOutput() -> BattleFieldViewCoordinatorOutput {
        return vc.battleFieldVC as! BattleFieldViewCoordinatorOutput
    }
    
    func produceLoseBattleOutput() -> LoseBattleViewCoordinatorOutput {
        return LoseBattleViewController()
    }
    
    func produceWinBattleOutput() -> WinBattleViewCoordinatorOutput {
        return WinBattleViewController()
    }
    
    func producePauseBattleOutput() -> PauseBattleViewCoordinatorOutput {
        return PauseBattleViewController()
    }
}

extension FlowFactoryImp: MainFlowFactory {
    func produceHomePageOutput() -> HomePageViewCoordinatorOutput {
        return HomePageViewController()
    }
}
