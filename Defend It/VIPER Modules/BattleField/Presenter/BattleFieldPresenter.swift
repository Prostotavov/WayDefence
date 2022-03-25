// 
//  BattleFieldPresenter.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation
import SceneKit

class BattleFieldPresenter: BattleFieldViewOutput, BattleFieldInteractorOutput {

    weak var view: BattleFieldViewInput!
    var interactor: BattleFieldInteractorInput!
    var router: BattleFieldRouterInput!
    
    func createGround() -> [[GroundCell]] {
        return interactor.createGround()
    }
    
    func createFence() -> [FenceCell] {
        return interactor.createFence()
    }
    
    func getEnemy() -> Enemy {
        return interactor.getEnemy()
    }
    
    func setupCamera() -> SCNNode {
        interactor.setupCamera()
    }
    
    func showTowerSelectionPanel(On position: SCNVector3) -> SCNNode {
        interactor.showTowerSelectionPanel(On: position)
    }
    
    func build(_ building: Buildings, On position: SCNVector3) -> SCNNode {
        interactor.build(building, On: position)
    }

    func run() {
        interactor.run()
    }
    
    func deleteBuilding(with name: String) {
        interactor.deleteBuilding(with: name)
    }
}
