//
//  GoblinSL.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

struct GoblinSL: Enemy, Hashable {
    
    var id: UUID
    var race: EnemyRaces = .goblin
    var level: EnemyLevels = .firstLevel
    var speed: Int = 7
    var enemyNode: SCNNode
    var path: [SCNVector3] = []
    
    init(_ enemyNode: SCNNode) {
        self.enemyNode = enemyNode
        id = UUID()
        self.enemyNode.name = id.uuidString
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(race)
        hasher.combine(level)
    }
    
    static func ==(lhs: GoblinSL, rhs: GoblinSL) -> Bool {
        lhs.id == rhs.id
    }
}
