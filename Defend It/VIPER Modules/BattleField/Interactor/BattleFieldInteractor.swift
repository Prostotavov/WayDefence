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
    var decorationsManager: DecorationsManager!
    
    var camera: Camera = CameraImpl()

    
    func createGround() -> [[GroundCell]] {
        meadowManager.createGround()
    }
    
    func createFence() -> [FenceCell] {
        decorationsManager.createFence()
    }
    
    func getEnemy() -> Enemy {
        return enemiesManager.enemy
    }
    
    func setupCamera() -> SCNNode {
        return camera.setupCamera()
    }
    
    func showTowerSelectionPanel(On position: SCNVector3) -> SCNNode {
        buildingsManager.showTowerSelectionPanel(On: position)
    }
    
    func build(_ building: Buildings, On position: SCNVector3) ->  SCNNode {
        enemiesManager.prohibitWalking(On: Converter.toCoordinate(from: position))
        enemiesManager.sendEnemyByNewPath()
        return buildingsManager.build(building, On: position)
    }
    
    func runEnemy() {
        print("rum interactor")
        enemiesManager.sendEnemy()
    }
    
    func deleteBuilding(with name: String) {
        enemiesManager.allowWalking(On: Converter.toCoordinate(from: name))
        enemiesManager.sendEnemyByNewPath()
        buildingsManager.deleteBuilding(with: name)
    }

}
