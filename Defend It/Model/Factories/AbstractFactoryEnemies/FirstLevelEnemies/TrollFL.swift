//
//  TrollFL.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

struct TrollFL: Enemy, Hashable {
    
    var id: UUID
    var race: EnemyRaces = .troll
    var level: EnemyLevels = .firstLevel
    var speed: Int = 3
    var enemyNode: SCNNode
    var path: [SCNVector3] = []
    var healthPoints: CGFloat = 300
    var coinMurderReward: Int = 5
    var pointsMurderReward: Int = 10
    
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
    
    static func ==(lhs: TrollFL, rhs: TrollFL) -> Bool {
        lhs.id == rhs.id
    }
}
