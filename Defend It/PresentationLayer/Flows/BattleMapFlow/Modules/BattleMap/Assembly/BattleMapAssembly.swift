// 
//  BattleMapAssembly.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import UIKit

class BattleMapAssembly: BattleMapAssemblyProtocol {
    
    func assemblyModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? BattleMapViewController {
            assembly(viewController: viewController)
        }
    }
    
    private func assembly(viewController: BattleMapViewController) {
        
        let presenter = BattleMapPresenter()
        let interactor = BattleMapInteractor()
        
        presenter.view = viewController
        presenter.coordinator = viewController
        presenter.interactor = interactor

        interactor.output = presenter
        
        viewController.output = presenter
        
    }
    
}
