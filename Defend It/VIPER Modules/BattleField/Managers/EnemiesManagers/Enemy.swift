//
//  Enemy.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import Foundation
import SceneKit

protocol Enemy {
    
    var scene: SCNScene {get set}
    var scnEnemyNode: SCNNode {get set}
    mutating func run(by path: [SCNVector3])
    var coordinate: (Int, Int) {get set}
}

struct EnemyImpl: Enemy {
    
    var scene: SCNScene
    var scnEnemyNode: SCNNode
    var coordinate: (Int, Int) = (3, 0)
    
    var enemyRunQueue = OperationQueue()
    var enemyRunOperation : EnemyRunOperation!
    
    init() {
        scene = SCNScene(named: "art.scnassets/allElements.scn")!
        scnEnemyNode = scene.rootNode.childNode(withName: "enemy", recursively: true)!
        scnEnemyNode.position = Converter.toPosition(From: coordinate)
    }
    
    func runOneSquare(to location: SCNVector3) {
        scnEnemyNode.removeAllActions()
        let time = 1.0
        let action = SCNAction.move(to: location, duration: time)
        scnEnemyNode.runAction(action)
    }
    
    mutating func run(by path: [SCNVector3]) {
        enemyRunOperation = EnemyRunOperation(by: path, runOneSquare: runOneSquare)
        enemyRunQueue.addOperation(enemyRunOperation)
    }

}
