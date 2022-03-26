//
//  GoblinSL.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

class GoblinSL: EnemyTest {
    
    var race: EnemyRaces = .orc
    var level: EnemyLevels = .firstLevel
    var enemyNode: SCNNode
    
    required init(_ enemyNode: SCNNode) {
        self.enemyNode = enemyNode
    }
}
