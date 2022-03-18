// 
//  HomePageRouter.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import UIKit
import SceneKit

class HomePageRouter: HomePageRouterInput {
    
    weak var view: UIViewController!
    
    func showBattleField() {
        let battleFieldVC = BattleFieldViewController()
        battleFieldVC.modalPresentationStyle = .fullScreen
        view.present(battleFieldVC, animated: true)
    }
}
