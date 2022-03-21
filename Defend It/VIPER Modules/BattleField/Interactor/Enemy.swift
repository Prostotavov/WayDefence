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
    func runToCastle(path: [SCNVector3])
    
}

struct EnemyImpl: Enemy {
    
    var scene: SCNScene
    var scnEnemyNode: SCNNode
    
    init(size: Int) {
        scene = SCNScene(named: "art.scnassets/allElements.scn")!
        scnEnemyNode = scene.rootNode.childNode(withName: "enemy", recursively: true)!
        scnEnemyNode.position = SCNVector3(-0.25, 0, CGFloat(size/4) + 0.5)
    }
    
    func runOneSquare(with location: SCNVector3) {
        scnEnemyNode.removeAllActions()
        let time = 2.0
        let action = SCNAction.move(to: location, duration: time)
        scnEnemyNode.runAction(action)
    }
    
    func runToCastle(path: [SCNVector3]) {
        for (i, location) in path.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 * Double(i)) {
                print(location)
                runOneSquare(with: location)
            }
        }
    }

}
