//
//  OrcFL.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

struct OrcFL: Enemy, Hashable {
    
    var ID: UUID
    var race: EnemyRaces = .orc
    var level: EnemyLevels = .firstLevel
    var speed: Int = 30
    var enemyNode: SCNNode
    var path: [SCNVector3]?
    
    init(_ enemyNode: SCNNode) {
        self.enemyNode = enemyNode
        ID = UUID()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ID)
        hasher.combine(race)
        hasher.combine(level)
    }
    
    static func ==(lhs: OrcFL, rhs: OrcFL) -> Bool {
        lhs.ID == rhs.ID
    }
}

