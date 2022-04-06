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
    
    func setupCamera() -> SCNNode {
        interactor.setupCamera()
    }
    
    func showTowerSelectionPanel(On position: SCNVector3) -> SCNNode {
        interactor.showTowerSelectionPanel(On: position)
    }
    
    func showTowerSelectionPanel(for buildingName: String ) -> SCNNode {
        interactor.showTowerSelectionPanel(for: buildingName)
    }
    
    func build(_ building: BuildingTypes, On position: SCNVector3) -> SCNNode {
        interactor.build(building, On: position)
    }

    func runEnemies() {
        interactor.runEnemies()
    }
    
    func deleteBuilding(with name: String) {
        interactor.deleteBuilding(with: name)
    }
    
    func getEnemies() -> Set<AnyEnemy> {
        interactor.getEnemies()
    }
    
    func getBuildingName(with coordinate: (Int, Int)) -> String {
        interactor.getBuildingName(with: coordinate)
    }
}
