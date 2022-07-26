// 
//  HomePageAssembly.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import UIKit

class HomePageAssembly: NSObject, HomePageAssemblyProtocol {
    
    func assemblyModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? HomePageViewController {
            assembly(with: viewController)
        }
    }
    
    private func assembly(with viewController: HomePageViewController) {
        
        let presenter = HomePagePresenter()
        let interactor = HomePageInteractor()
            
        presenter.view = viewController
        presenter.coordinator = viewController
        presenter.interactor = interactor
        
        interactor.output = presenter
        
        viewController.output = presenter
    }
    
}
