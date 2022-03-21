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
    var enemyPathManager: EnemyPathManager!
    
    var ground: Ground = GroundImpl()
    var fence: Fence = FenceImpl()
    var camera: Camera = CameraImpl()
    var towerSelectionPanel: TowerSelectionPanel = TowerSelectionPanelImpl()
    var enemy: Enemy!
    
    func createGround(size: Int) -> [[GroundCell]] {
        for row in ground.createGround(size: size) {
            for cell in row {
                cell.scnGroundNode.position = calculatePositionFor(coordinate: cell.coordinate)
            }
        }
        return ground.createGround(size: size)
    }
    
    func createFence(size: Int) -> [FenceCell] {
        return fence.createFence(size: size)
    }
    
    func getEnemy(size: Int) -> Enemy {
        let position = calculateStartPosotionForEnemy(size: size)
        enemy = EnemyImpl(position: position)
        return enemy
    }
    
    
    func setupCamera() -> SCNNode {
        return camera.setupCamera()
    }
    
    func getTowerSelectionPanel(position: SCNVector3) -> SCNNode {
        return towerSelectionPanel.createTowerSelectionPanel(position: position)
    }
    
    func create(_ building: Buildings, On position: SCNVector3) ->  SCNNode {
        let coordinate = calculateCoordinateFor(position: position)
        return ground.create(building, On: position, And: coordinate)

    }
    
    func runToCastle() {
    enemy.runToCastle(path: calculatePathForEnemy())
    }
    
    func calculateStartPosotionForEnemy(size: Int) -> SCNVector3 {
        return SCNVector3(-0.25 + CGFloat(size) / 4, 0, -0.25)
    }
    
    func calculatePositionFor(coordinate: (Int, Int)) -> SCNVector3 {
        return SCNVector3(Float(coordinate.0)/2, 0, Float(coordinate.1)/2)
    }
    
    func calculateCoordinateFor(position: SCNVector3) -> (Int, Int) {
        return (Int(position.x * 2), Int(position.z * 2))
    }
    
    func calculatePathFromCoorToPosinion(coorPath: [(Int, Int)]) -> [SCNVector3]{
        var path: [SCNVector3] = []
        for step in coorPath {
            path.append(calculatePositionFor(coordinate: step))
        }
        return path
    }
    
    func calculatePathForEnemy() -> [SCNVector3]{
        return calculatePathFromCoorToPosinion(coorPath: enemyPathManager.calculatePathAStar(ground: ground.ground))
    }
    
    
}
