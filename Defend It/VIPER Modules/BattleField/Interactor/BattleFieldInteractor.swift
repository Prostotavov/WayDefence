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
    var buildingsManager: BuildingsManager!
    var enemiesManager: EnemiesManager!
    var decorationsManager: DecorationsManager!
    
    var camera: Camera = CameraImpl()

    
    func createGround() -> [[GroundCell]] {
        buildingsManager.createGround()
    }
    
    func createFence() -> [FenceCell] {
        decorationsManager.createFence()
    }
    
    func getEnemy() -> Enemy {
        enemiesManager.enemy
    }
    
    func setupCamera() -> SCNNode {
        return camera.setupCamera()
    }
    
    func showTowerSelectionPanel(On position: SCNVector3) -> SCNNode {
        buildingsManager.showTowerSelectionPanel(On: position)
    }
    
    func build(_ building: Buildings, On position: SCNVector3) ->  SCNNode {
        buildingsManager.build(building, On: position)
    }
    
    func run() {
        enemiesManager.run()
    }

}
