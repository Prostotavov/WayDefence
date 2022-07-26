//
//  FlowFactoryImp.swift
//  Defend It
//
//  Created by Роман Сенкевич on 25.07.22.
//

import Foundation

import UIKit.UIViewController

class FlowFactoryImp: BattleFlowFactory {
    
    func produceLoadBattleOutput() -> LoadBattleViewCoordinatorOutput {
        return LoadBattleViewController()
    }
    
    func produceLoseBattleOutput() -> LoseBattleViewCoordinatorOutput {
        return LoseBattleViewController()
    }
}

extension FlowFactoryImp: MainFlowFactory {
    func produceHomePageOutput() -> HomePageViewCoordinatorOutput {
        return HomePageViewController()
    }
}
