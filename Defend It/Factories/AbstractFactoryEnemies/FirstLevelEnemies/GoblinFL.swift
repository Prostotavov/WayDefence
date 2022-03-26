//
//  GoblinFL.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

class GoblinFL: EnemyTest {
    
    var race: EnemyRaces = .orc
    var level: EnemyLevels = .firstLevel
    var enemyNode: SCNNode
    
    required init(_ enemyNode: SCNNode) {
        self.enemyNode = enemyNode
    }
}
