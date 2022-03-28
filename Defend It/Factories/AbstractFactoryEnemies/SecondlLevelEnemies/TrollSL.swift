//
//  TrollSL.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

class TrollSL: Enemy {
    
    var race: EnemyRaces = .orc
    var level: EnemyLevels = .firstLevel
    var speed: CGFloat = 5
    var enemyNode: SCNNode
    
    required init(_ enemyNode: SCNNode) {
        self.enemyNode = enemyNode
    }
}
