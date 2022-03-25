//
//  Enemy.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import Foundation
import SceneKit

protocol Enemy {
    
    var enemyScene: SCNScene {get set}
    var enemyNode: SCNNode {get set}
    func run(by path: [SCNVector3])
    var coordinate: (Int, Int) {get set}
    func stopEnemyAndRunNewPath(by path: [SCNVector3])
}

class EnemyImpl: Enemy {
    
    var enemyScene: SCNScene
    var enemyNode: SCNNode
    var coordinate: (Int, Int) = (3, 0)
    
    var enemyRunQueue = OperationQueue()
    var enemyRunOperation : EnemyRunOperation!
    
    init() {
        enemyScene = SCNScene(named: ScenePaths.enemyScene.rawValue)!
        enemyNode = enemyScene.rootNode.childNode(withName: NodeNames.enemy.rawValue, recursively: true)!
        enemyNode.position = Converter.toPosition(from: coordinate)
    }
    
    func stopEnemyAndRunNewPath(by path: [SCNVector3]) {
        if enemyRunOperation != nil {
            enemyRunOperation.cancel()
            enemyNode.removeAllActions()
            run(by: path)
        }
    }
    
    func runOneSquare(to location: SCNVector3) {
        enemyNode.removeAllActions()
        let time = 1.0
        let action = SCNAction.move(to: location, duration: time)
        enemyNode.runAction(action)
    }
    
    func run(by path: [SCNVector3]) {
        print("Start Run")
        enemyRunOperation = EnemyRunOperation(by: path, runOneSquare: runOneSquare)
        enemyRunQueue.addOperation(enemyRunOperation)
    }

}
