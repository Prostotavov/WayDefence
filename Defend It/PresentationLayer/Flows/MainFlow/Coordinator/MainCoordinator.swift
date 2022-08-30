//
//  MainCoordinator.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import Foundation

class MainCoordinator: BaseCoordinator , MainCoordinatorOutput {
    
    // MARK: - AuthorizationCoordinatorOutput
    
    var finishFlow: (() -> Void)?
    
    private let factory: MainFlowFactory
    private let router: Router
    
    init(router: Router, factory: MainFlowFactory) {
        
        self.factory = factory
        self.router = router
    }
    
    // MARK: - BaseCoordinator
    
    override func start() {
        showHomePage()
    }
    
    // MARK: - Flow's controllers

    private func showHomePage() {
        let homePageOutput = factory.produceHomePageOutput()
        
        homePageOutput.onStartBattle = { [weak self] in
            self?.finishFlow?()
        }
        
        homePageOutput.onBagButton = { [weak self] in
            self?.showBag()
        }
        
        router.setRootModule(homePageOutput, hideBar: true)
    }
    
    private func showBag() {
        let bagOutput = factory.produceBagOutput()
        
        bagOutput.onBack = { [weak self] in
            self?.router.dismissModule(animated: false, completion: nil)
        }
        
        
        router.present(bagOutput, animated: false)
    }

}
