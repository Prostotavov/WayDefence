// 
//  AchieveAssembly.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.09.22.
//

import UIKit

class AchieveAssembly: AchieveAssemblyProtocol {
    
    func assemblyModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? AchieveViewController {
            assembly(viewController: viewController)
        }
    }
    
    private func assembly(viewController: AchieveViewController) {
        
        let presenter = AchievePresenter()
        let interactor = AchieveInteractor()
        
        presenter.view = viewController
        presenter.coordinator = viewController
        presenter.interactor = interactor

        interactor.output = presenter
        
        viewController.output = presenter
        
    }
    
}
