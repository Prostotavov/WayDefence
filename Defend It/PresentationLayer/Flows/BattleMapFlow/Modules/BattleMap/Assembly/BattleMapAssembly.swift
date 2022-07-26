// 
//  BattleMapAssembly.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import UIKit

class BattleMapAssembly: BattleMapAssemblyProtocol {
    
    func assemblyModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? ___VARIABLE_productName___ViewController {
            assembly(viewController: viewController)
        }
    }
    
    private func assembly(viewController: ___VARIABLE_productName___ViewController) {
        
        let presenter = ___VARIABLE_productName___Presenter()
        let interactor = ___VARIABLE_productName___Interactor()
        
        presenter.view = viewController
        presenter.coordinator = viewController
        presenter.interactor = interactor

        interactor.output = presenter
        
        viewController.output = presenter
        
    }
    
}
