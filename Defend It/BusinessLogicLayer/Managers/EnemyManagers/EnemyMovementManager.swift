//
//  EnemyMovementManager.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.08.22.
//

import SceneKit

class EnemyMovementManager {
    
    var pathCounter: Int = 0
    var intervalCounter: Int!
    var enemiesState: EnemiesStates!
    
    func runEnemies(enemies: Set<AnyEnemy>) {
        if enemiesState == .inactive {return}
        for enemy in enemies {
            let path = EnemyPathManager.shared.calculatePath(for: enemy)
            enemy.setPath(path)
        }
    }
    
    func runOneSquare(_ enemy: AnyEnemy, to location: SCNVector3) {
        var duration: TimeInterval
        if pathCounter == 0 {
            duration = getDurationForStepAfterBuilding(for: enemy)
        } else {
            duration = Converter.toTimeInterval(from: enemy.speed)
        }
        enemy.counter += Converter.toCounter(from: duration)
        let action = SCNAction.move(to: location, duration: duration)
        enemy.enemyNode.removeAllActions()
        enemy.enemyNode.runAction(action)
    }
    
    func getDurationForStepAfterBuilding<T: Enemy>(for enemy: T) -> TimeInterval {
        let distination = Converter.toDistination(between: enemy.enemyNode.position, and: enemy.path.first!)
        let defaultDuration = Converter.toTimeInterval(from: enemy.speed)
        return  TimeInterval(defaultDuration * distination / 0.5)
    }
    
}
