//
//  GoblinSL.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

class GoblinSL: Enemy {
    
    var race: EnemyRaces = .orc
    var level: EnemyLevels = .firstLevel
    var speed: CGFloat = 10
    var enemyNode: SCNNode
    
    required init(_ enemyNode: SCNNode) {
        self.enemyNode = enemyNode
    }
}
