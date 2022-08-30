// 
//  BagAssembly.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.08.22.
//

import UIKit

class BagAssembly: BagAssemblyProtocol {
    
    func assemblyModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? BagViewController {
            assembly(viewController: viewController)
        }
    }
    
    private func assembly(viewController: BagViewController) {
        
        let presenter = BagPresenter()
        let interactor = BagInteractor()
        
        presenter.view = viewController
        presenter.coordinator = viewController
        presenter.interactor = interactor

        interactor.output = presenter
        
        viewController.output = presenter
        
    }
    
}
