//
//  OrcFL.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

struct OrcFL: Enemy, Hashable {
    
    var id: UUID
    var race: EnemyRaces = .orc
    var level: EnemyLevels = .firstLevel
    var speed: Int = 2
    var enemyNode: SCNNode
    var path: [SCNVector3] = []
    var healthPoints: CGFloat = 300
    var coinMurderReward: Int = 5
    
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
    
    static func ==(lhs: OrcFL, rhs: OrcFL) -> Bool {
        lhs.id == rhs.id
    }
}

