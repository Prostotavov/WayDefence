//
//  FlowFactoryImp.swift
//  Defend It
//
//  Created by Роман Сенкевич on 25.07.22.
//

import Foundation

import UIKit.UIViewController

class FlowFactoryImp: BattleFlowFactory {
    
    static let defaultFactory = FlowFactoryImp()
    
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
    
    func produceBagOutput() -> BagViewCoordinatorOutput {
        return BagViewController()
    }
}

extension FlowFactoryImp: BattleMapFlowFactory {
    func produceBattleMapOutput() -> BattleMapViewCoordinatorOutput {
        return BattleMapViewController()
    }
}
