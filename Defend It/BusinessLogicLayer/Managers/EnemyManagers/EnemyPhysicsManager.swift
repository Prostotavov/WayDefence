//
//  EnemyPhysicsManager.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.08.22.
//

import SceneKit

class EnemyPhysicsManager {
    
    static func addPhysicsBody(for enemy: AnyEnemy) {
        let radius = 0.1
        let physicsShape = SCNPhysicsShape(geometry: SCNSphere(radius: radius))
        let physicsBody = SCNPhysicsBody(type: .kinematic, shape: physicsShape)
        physicsBody.isAffectedByGravity = false
        physicsBody.categoryBitMask = 2
        enemy.enemyNode.physicsBody = physicsBody
    }
}
