// 
//  WinBattleAssembly.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import UIKit

class WinBattleAssembly: WinBattleAssemblyProtocol {
    
    func assemblyModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? WinBattleViewController {
            assembly(viewController: viewController)
        }
    }
    
    private func assembly(viewController: WinBattleViewController) {
        
        let presenter = WinBattlePresenter()
        let interactor = WinBattleInteractor()
        
        presenter.view = viewController
        presenter.coordinator = viewController
        presenter.interactor = interactor

        interactor.output = presenter
        
        viewController.output = presenter
        
    }
    
}
