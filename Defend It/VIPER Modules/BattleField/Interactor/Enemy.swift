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
}

struct EnemyImpl: Enemy {
    
    var scene: SCNScene
    var scnEnemyNode: SCNNode
    
    init(size: Int) {
        scene = SCNScene(named: "art.scnassets/allElements.scn")!
        scnEnemyNode = scene.rootNode.childNode(withName: "enemy", recursively: true)!
        scnEnemyNode.position = SCNVector3(-0.25, 0, CGFloat(size/4) + 0.5)
    }

}
