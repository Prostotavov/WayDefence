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
    
    func createGround(size: Int) -> [[GroundCell]] {
        return ground.createGround(size: size)
    }
    
    func createFence(size: Int) -> [FenceCell] {
        return fence.createFence(size: size)
    }
    
    func getEnemy(size: Int) -> Enemy {
        return EnemyImpl(size: size)
    }
    
    func setupCamera() -> SCNNode {
        return camera.setupCamera()
    }
    
    func getTowerSelectionPanel(position: SCNVector3) -> SCNNode {
        return towerSelectionPanel.createTowerSelectionPanel(position: position)
    }
    
}
