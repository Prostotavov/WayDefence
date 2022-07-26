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
    
    func produceLoseBattleOutput() -> LoseBattleViewCoordinatorOutput {
        return LoseBattleViewController()
    }
    
    func produceBattleFieldOutput() -> BattleFieldViewCoordinatorOutput {
        return vc.battleFieldVC as! BattleFieldViewCoordinatorOutput
    }
}

extension FlowFactoryImp: MainFlowFactory {
    func produceHomePageOutput() -> HomePageViewCoordinatorOutput {
        return HomePageViewController()
    }
}
