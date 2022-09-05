// 
//  QuestsAssembly.swift
//  Defend It
//
//  Created by Роман Сенкевич on 5.09.22.
//

import UIKit

class QuestsAssembly: QuestsAssemblyProtocol {
    
    func assemblyModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? QuestsViewController {
            assembly(viewController: viewController)
        }
    }
    
    private func assembly(viewController: QuestsViewController) {
        
        let presenter = QuestsPresenter()
        let interactor = QuestsInteractor()
        
        presenter.view = viewController
        presenter.coordinator = viewController
        presenter.interactor = interactor

        interactor.output = presenter
        
        viewController.output = presenter
    }
    
}
