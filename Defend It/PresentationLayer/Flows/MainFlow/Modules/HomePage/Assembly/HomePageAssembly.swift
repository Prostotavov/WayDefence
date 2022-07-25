// 
//  HomePageAssembly.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import UIKit

class HomePageAssembly: NSObject, HomePageAssemblyProtocol {
    
    func assembly(with viewController: HomePageViewController) {
        
        let presenter = HomePagePresenter()
        let interactor = HomePageInteractor()
        let router = HomePageRouter()
        let dataManager = DataManagerImpl()
        
        viewController.output = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.dataManager = dataManager
        interactor.output = presenter
        
        router.view = viewController
        
    }
    
}
