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
    func run(by path: [SCNVector3])
    var coordinate: (Int, Int) {get set}
}

struct EnemyImpl: Enemy {
    
    var scene: SCNScene
    var scnEnemyNode: SCNNode
    var coordinate: (Int, Int) = (3, 0)
    
    init() {
        scene = SCNScene(named: "art.scnassets/allElements.scn")!
        scnEnemyNode = scene.rootNode.childNode(withName: "enemy", recursively: true)!
        scnEnemyNode.position = Converter.toPosition(From: coordinate)
    }
    
    func runOneSquare(to location: SCNVector3) {
        scnEnemyNode.removeAllActions()
        let time = 2.0
        let action = SCNAction.move(to: location, duration: time)
        scnEnemyNode.runAction(action)
    }
    
    func run(by path: [SCNVector3]) {
        for (i, location) in path.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 * Double(i)) {
                print(location)
                runOneSquare(to: location)
            }
        }
    }

}
