//
//  TrollTL.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

struct TrollTL: Enemy, Hashable {
    
    var id: UUID
    var race: EnemyRaces = .troll
    var level: EnemyLevels = .thirdLevel
    var speed: Int = 5
    var enemyNode: SCNNode
    var path: [SCNVector3] = []
    var healthPoints: CGFloat = 1000
    var coinMurderReward: Int = 15
    var pointsMurderReward: Int = 70
    
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
    
    static func ==(lhs: TrollTL, rhs: TrollTL) -> Bool {
        lhs.id == rhs.id
    }
}
