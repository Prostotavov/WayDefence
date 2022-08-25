//
//  EnemyRotationManager.swift
//  Defend It
//
//  Created by Роман Сенкевич on 17.08.22.
//

import SceneKit

struct EnemyRotationManager {
    
    static func rotate(enemy: AnyEnemy) {
                
        let currentX = enemy.enemyNode.position.x
        let currentZ = enemy.enemyNode.position.z
        
        guard let firstStep = enemy.path.first else {return}
        
        let targerX = firstStep.x
        let targerZ = firstStep.z
        
        let difX = targerX - currentX
        let difZ = targerZ - currentZ
        
        let targetAngle = calculateAngle(difX: difX, difZ: difZ)
        
        let action = SCNAction.rotateTo(x: 0, y: targetAngle, z: 0, duration: 0.4)
        enemy.enemyNode.runAction(action)

    }
    
    static private func calculateAngle(difX x: Float, difZ z: Float) -> Double {
        if abs(x) < 0.01 && z < 0 {
            return atan(Double(x/z)) + 3.14
        }
        return atan(Double(x/z))
    }
}


// MAP:
//         0   1   2   3   4   5   6
//         _________________________
//    0   |         north           |
//    1   |                         |
//    2   |                         |
//    3   |west                 east|
//    4   |                         |
//    5   |         south           |
//    6   |_________________________|
//
//                              \           \
//                               \           \
//                                \           \
//                                 \camera here\
