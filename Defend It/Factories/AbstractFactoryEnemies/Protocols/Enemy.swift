//
//  Enemy.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

protocol Enemy: Hashable {
    
    var ID: UUID {get}
    var race: EnemyRaces {get}
    var level: EnemyLevels {get}
    var speed: Int {get}  // enemy speed = count of squares completed per minute
    var enemyNode: SCNNode {get set}
    var path: [SCNVector3] {get set}

}

class AnyEnemy: Enemy {
    
    var ID: UUID
    var race: EnemyRaces
    var level: EnemyLevels
    var speed: Int
    var enemyNode: SCNNode
    var path: [SCNVector3]
    
    // adding vars
    var counter: Int
    
    init<T: Enemy>(_ object: T) {
        ID = object.ID
        race = object.race
        level = object.level
        speed = object.speed
        enemyNode = object.enemyNode
        path = object.path
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
        lhs.ID == rhs.ID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ID)
        hasher.combine(race)
        hasher.combine(level)
    }
}

