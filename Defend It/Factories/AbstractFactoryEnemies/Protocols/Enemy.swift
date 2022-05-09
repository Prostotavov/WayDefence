//
//  Enemy.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

protocol Enemy: Hashable {
    
    var id: UUID {get}
    var race: EnemyRaces {get}
    var level: EnemyLevels {get}
    var speed: Int {get}  // enemy speed = count of squares completed per minute
    var enemyNode: SCNNode {get set}
    var path: [SCNVector3] {get set}
    var healthPoints: CGFloat {get set}
    var coinMurderReward: Int {get set}

}

class AnyEnemy: Enemy {
    
    var id: UUID
    var race: EnemyRaces
    var level: EnemyLevels
    var speed: Int
    var enemyNode: SCNNode
    var path: [SCNVector3]
    var healthPoints: CGFloat
    var coinMurderReward: Int
    
    // adding vars
    var counter: Int
    
    init<T: Enemy>(_ object: T) {
        id = object.id
        race = object.race
        level = object.level
        speed = object.speed
        enemyNode = object.enemyNode
        path = object.path
        healthPoints = object.healthPoints
        coinMurderReward = object.coinMurderReward
        // adding vars
        counter = 0
    }
    
    func setPath(_ path: [SCNVector3]) {
        self.path = path
    }
    
    func removeFirstStep() {
        path.removeFirst()
    }
    
    static func == (lhs: AnyEnemy, rhs: AnyEnemy) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(race)
        hasher.combine(level)
    }
}

