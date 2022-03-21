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
    var dataManager: DataManager!
    
    var ground: Ground = GroundImpl()
    var fence: Fence = FenceImpl()
    var camera: Camera = CameraImpl()
    var towerSelectionPanel: TowerSelectionPanel = TowerSelectionPanelImpl()
    var enemy: Enemy!
    
    func createGround(size: Int) -> [[GroundCell]] {
        return ground.createGround(size: size)
    }
    
    func createFence(size: Int) -> [FenceCell] {
        return fence.createFence(size: size)
    }
    
    func getEnemy(size: Int) -> Enemy {
        enemy = EnemyImpl(size: size)
        return enemy
    }
    
    func setupCamera() -> SCNNode {
        return camera.setupCamera()
    }
    
    func getTowerSelectionPanel(position: SCNVector3) -> SCNNode {
        return towerSelectionPanel.createTowerSelectionPanel(position: position)
    }
    
    func create(_ building: Buildings, On position: SCNVector3) ->  SCNNode {
        ground.create(building, On: position)
    }
    
    func runToCastle(path: [SCNVector3]) {
    enemy.runToCastle(path: path)
    }
    
}
