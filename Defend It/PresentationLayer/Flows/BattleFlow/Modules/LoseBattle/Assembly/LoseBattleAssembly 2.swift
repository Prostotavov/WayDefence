// 
//  LoseBattleAssembly.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import UIKit

class LoseBattleAssembly: LoseBattleAssemblyProtocol {
    
    func assemblyModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? LoseBattleViewController {
            assembly(viewController: viewController)
        }
    }
    
    private func assembly(viewController: LoseBattleViewController) {
        
        let presenter = LoseBattlePresenter()
        let interactor = LoseBattleInteractor()
        
        presenter.view = viewController
        presenter.coordinator = viewController
        presenter.interactor = interactor

        interactor.output = presenter
        
        viewController.output = presenter
        
    }
    
}
