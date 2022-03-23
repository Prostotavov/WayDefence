//
//  Enemy.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import Foundation
import SceneKit

protocol Enemy {
    
    var delegate: EnemyDelegate! {get set}
    var scene: SCNScene {get set}
    var scnEnemyNode: SCNNode {get set}
    func run(by path: [SCNVector3])
    var coordinate: (Int, Int) {get set}
}

protocol EnemyDelegate {
    func calculatePath() -> [(Int, Int)]
    var graph: BattleFieldGraph! {get set}
}

class EnemyImpl: Enemy {
    
    var scene: SCNScene
    var scnEnemyNode: SCNNode
    var coordinate: (Int, Int) = (3, 0)
    
    var delegate: EnemyDelegate!
    
    var enemyRunQueue = OperationQueue()
    var enemyRunOperation : EnemyRunOperation!
    
    init() {
        scene = SCNScene(named: "art.scnassets/allElements.scn")!
        scnEnemyNode = scene.rootNode.childNode(withName: "enemy", recursively: true)!
        scnEnemyNode.position = Converter.toPosition(From: coordinate)
        NotificationCenter.default.addObserver(self, selector: #selector(stopEnemyAndRunNewPath), name: Notification.Name("test"), object: nil)
    }
    
    @objc
    func stopEnemyAndRunNewPath() {
        if enemyRunOperation != nil {
            enemyRunOperation.cancel()
            scnEnemyNode.removeAllActions()
            run(by: Converter.toPositions(From:delegate.calculatePath()))
        }
        print()
        print("delegate")
        print(delegate.graph)
        print()
    }
    
    func runOneSquare(to location: SCNVector3) {
        scnEnemyNode.removeAllActions()
        let time = 1.0
        let action = SCNAction.move(to: location, duration: time)
        scnEnemyNode.runAction(action)
    }
    
    func run(by path: [SCNVector3]) {
        print("Start Run")
        enemyRunOperation = EnemyRunOperation(by: path, runOneSquare: runOneSquare)
        enemyRunQueue.addOperation(enemyRunOperation)
    }

}
