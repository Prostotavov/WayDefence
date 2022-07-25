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

    

}
