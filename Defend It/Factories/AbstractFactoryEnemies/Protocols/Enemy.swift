//
//  Enemy.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

protocol Enemy {
    
    var race: EnemyRaces {get}
    var level: EnemyLevels {get}
    var speed: CGFloat {get}
    var enemyNode: SCNNode {get set}
    
    init(_ enemyNode: SCNNode)
}

