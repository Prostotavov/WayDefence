//
//  LoadBattleAssembly.swift
//  Defend It
//
//  Created by Роман Сенкевич on 25.07.22.
//

import UIKit

class LoadBattleModuleAssembly {

    func assemblyModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? LoadBattleViewController {
            assembly(viewController: viewController)
        }
    }

    private func assembly(viewController: LoadBattleViewController) {
        let presenter = LoadBattlePresenter()
        presenter.view = viewController
        presenter.coordinator = viewController

        let interactor = LoadBattleInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}

