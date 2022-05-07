//
//  TrollFL.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

struct TrollFL: Enemy, Hashable {
    
    var ID: UUID
    var race: EnemyRaces = .troll
    var level: EnemyLevels = .firstLevel
    var speed: Int = 10
    var enemyNode: SCNNode
    var path: [SCNVector3] = []
    
    init(_ enemyNode: SCNNode) {
        self.enemyNode = enemyNode
        ID = UUID()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ID)
        hasher.combine(race)
        hasher.combine(level)
    }
    
    static func ==(lhs: TrollFL, rhs: TrollFL) -> Bool {
        lhs.ID == rhs.ID
    }
}
