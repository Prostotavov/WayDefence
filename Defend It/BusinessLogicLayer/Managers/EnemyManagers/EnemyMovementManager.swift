//
//  EnemyMovementManager.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.08.22.
//

import SceneKit

protocol EnemyMovementManagerOutput: AnyObject {
    func enemyReachedCastle(enemy: AnyEnemy)
    func addNodeToScene(_ node: SCNNode)
}

protocol EnemyMovementManagerInput: AnyObject {
    func setupManager(interval: Int, output: EnemyMovementManagerOutput)
    func execute(command: EnemyMovementManagerCommands, for enemies: Set<AnyEnemy>)
}

class EnemyMovementManager: EnemyMovementManagerInput {
    
    private var pathCounter: Int = 0
    private var intervalCounter: Int!
    private var intervalBetweenEnemies: Int!
    private var enemiesState: EnemiesStates = .inactive
    
    weak var output: EnemyMovementManagerOutput!
    
    func setupManager(interval: Int, output: EnemyMovementManagerOutput) {
        self.intervalCounter = interval
        self.intervalBetweenEnemies = interval
        self.output = output
    }
    
    private func runEnemies(enemies: Set<AnyEnemy>) {
        if enemiesState == .inactive {return}
        for enemy in enemies {
            let path = EnemyPathManager.shared.calculatePath(for: enemy)
            enemy.setPath(path)
        }
    }
    
    private func runOneSquare(_ enemy: AnyEnemy, to location: SCNVector3) {
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
    
    private func getDurationForStepAfterBuilding<T: Enemy>(for enemy: T) -> TimeInterval {
        let distination = Converter.toDistination(between: enemy.enemyNode.position, and: enemy.path.first!)
        let defaultDuration = Converter.toTimeInterval(from: enemy.speed)
        return  TimeInterval(defaultDuration * distination / 0.5)
    }
    
    
    private func resetEnemyCounter(enemies: Set<AnyEnemy>) {
        for enemy in enemies {
            enemy.counter = 0
        }
    }
    
    private func activateEnemies(enemies: Set<AnyEnemy>) {
        if intervalCounter  >= intervalBetweenEnemies {
            for enemy in enemies {
                if !enemy.isActive {
                    enemy.isActive = true
                    output.addNodeToScene(enemy.enemyNode)
                    intervalCounter = 0
                    resetEnemyCounter(enemies: enemies)
                    pathCounter = 0
                    runEnemies(enemies: enemies)
                    return
                }
            }
        }
    }
}

/// commands 
extension EnemyMovementManager {
    func execute(command: EnemyMovementManagerCommands, for enemies: Set<AnyEnemy>) {
        switch command {
        case .updateCounter:
            updateCounter(enemies: enemies)
        case .stopAllEnemies:
            stopAllEnemies(enemies: enemies)
        case .runAllEnemies:
            runAllEnemies(enemies: enemies)
        case .runByNewPath:
            runByNewPath(enemies: enemies)
        }
    }
    
    private func updateCounter(enemies: Set<AnyEnemy>) {
        
        if enemiesState == .inactive {return}
        intervalCounter += 1
        activateEnemies(enemies: enemies)
        
        // MARK: biggest bad practice in my code
        if pathCounter%5 == 0 { runEnemies(enemies: enemies)}
        
        for enemy in enemies {
            if !enemy.isActive {continue}
            if pathCounter == enemy.counter {
                if enemy.path.isEmpty {
                    output.enemyReachedCastle(enemy: enemy)
                    continue
                }
                let location = enemy.path.first!
                runOneSquare(enemy, to: location)
                enemy.path.removeFirst()
            }
        }
        pathCounter += 1
        // MARK: bad practice
        if pathCounter >= 99999 {
            pathCounter = 0
        }
    }
    
    private func runByNewPath(enemies: Set<AnyEnemy>) {
        resetEnemyCounter(enemies: enemies)
        pathCounter = 0
        runEnemies(enemies: enemies)
    }
    
    private func stopAllEnemies(enemies: Set<AnyEnemy>) {
        enemiesState = .inactive
        resetEnemyCounter(enemies: enemies)
        pathCounter = 0
        _ = enemies.map{$0.enemyNode.removeAllActions()}
    }
    
    private func runAllEnemies(enemies: Set<AnyEnemy>) {
        enemiesState = .active
        resetEnemyCounter(enemies: enemies)
        pathCounter = 0
        runEnemies(enemies: enemies)
    }
    
}
