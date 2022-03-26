//
//  EnemyTest.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

protocol EnemyTest {
    
    var race: EnemyRaces {get}
    var level: EnemyLevels {get}
    var enemyNode: SCNNode {get}
    
    init(_ enemyNode: SCNNode)
}
