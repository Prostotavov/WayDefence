// 
//  PauseBattleAssembly.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import UIKit

class PauseBattleAssembly: PauseBattleAssemblyProtocol {
    
    func assemblyModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? PauseBattleViewController {
            assembly(viewController: viewController)
        }
    }
    
    private func assembly(viewController: PauseBattleViewController) {
        
        let presenter = PauseBattlePresenter()
        let interactor = PauseBattleInteractor()
        
        presenter.view = viewController
        presenter.coordinator = viewController
        presenter.interactor = interactor

        interactor.output = presenter
        
        viewController.output = presenter
        
    }
    
}
