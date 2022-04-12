// 
//  BattleFieldInteractor.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation
import SceneKit

class BattleFieldInteractor: BattleFieldInteractorInput {
    
    weak var output: BattleFieldInteractorOutput!
    var meadowManager: MeadowManager!
    var buildingsManager: BuildingsManager!
    var enemiesManager: EnemiesManager!
    
    var camera: Camera = CameraImpl()

    
    func getGroundSquares() -> [[GroundSquareImpl]] {
        meadowManager.getGroundSquares()
    }
    
    func getEnemies() -> Set<AnyEnemy> {
        enemiesManager.enemies
    }
    
    func getCamera() -> SCNNode {
        camera.scnNode
    }
    
    func showTowerSelectionPanel(On position: SCNVector3) -> SCNNode {
        buildingsManager.showTowerSelectionPanel(On: position)
    }
    
    func showTowerSelectionPanel(for buildingName: String) -> SCNNode {
        buildingsManager.showTowerSelectionPanel(for: buildingName)
    }
    
    func build(_ building: BuildingTypes, On position: SCNVector3) ->  SCNNode {
        enemiesManager.prohibitWalking(On: Converter.toCoordinate(from: position))
        return buildingsManager.build(building, On: position)
    }
    
    func runEnemies() {
        enemiesManager.runEnemies()
    }
    
    func sellBuilding(with name: String) {
        enemiesManager.allowWalking(On: Converter.toCoordinate(from: name))
        buildingsManager.deleteBuilding(with: name)
    }
    
    func getBuildingName(with coordinate: (Int, Int)) -> String {
        buildingsManager.getBuildingName(with: coordinate)
    }

}
