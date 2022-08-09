//
//  FlowTabbarAssembly.swift
//  Defend It
//
//  Created by Роман Сенкевич on 6.08.22.
//

import UIKit

class FlowTabbarAssembly: FlowTabbarAssemblyProtocol {
    
    func assemblyModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? FlowTabbarController {
            assembly(viewController: viewController)
        }
    }
    
    private func assembly(viewController: FlowTabbarController) {

        let presenter = FlowTabbarPresenter()
        let interactor = FlowTabbarInteractor()
        
        presenter.view = viewController
        presenter.coordinator = viewController
        presenter.interactor = interactor

        interactor.output = presenter
        
        viewController.output = presenter
        
    }
    
}
