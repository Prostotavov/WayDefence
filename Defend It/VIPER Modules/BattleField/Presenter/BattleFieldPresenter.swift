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
    
    func showTowerSelectionPanel(On position: SCNVector3) -> SCNNode {
        interactor.showTowerSelectionPanel(On: position)
    }
    
    func showTowerSelectionPanel(for buildingName: String ) -> SCNNode {
        interactor.showTowerSelectionPanel(for: buildingName)
    }

}


// pressed functions
extension BattleFieldPresenter {
    func buildingIconPressed(_ building: BuildingTypes, On position: SCNVector3) -> SCNNode {
        interactor.build(building, On: position)
    }

    func enemyPressed() {
        interactor.runEnemies()
    }
    
    func sellIconPressed(for name: String) {
        interactor.sellBuilding(with: name)
    }
}

//get functions
extension BattleFieldPresenter {
    func getGroundSquares() -> [[GroundSquareImpl]] {
        interactor.getGroundSquares()
    }
    
    func getCamera() -> SCNNode {
        interactor.getCamera()
    }
    
    func getEnemies() -> Set<AnyEnemy> {
        interactor.getEnemies()
    }
    
    func getBuildingName(with coordinate: (Int, Int)) -> String {
        interactor.getBuildingName(with: coordinate)
    }
}
