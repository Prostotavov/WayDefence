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
            
            var actions: [SCNAction] = []
            
            for i in 0...enemy.path.count {
                
                if i == enemy.path.count - 1 {break}
                if enemy.path.isEmpty {
                    break
                }
                
                let different = SCNVector3(x: enemy.path[i].x - enemy.path[i + 1].x,
                                           y: enemy.path[i].y - enemy.path[i + 1].y,
                                           z: enemy.path[i].z - enemy.path[i + 1].z)
                
                var angle: Double = 0
                
                if abs(different.x) < 0.01 && different.z < 0 {
                    angle = atan(Double(different.x/different.z)) + 3.14
                } else {
                    angle = atan(Double(different.x/different.z))
                }
               
                
                let rotationAction = SCNAction.rotateTo(x: 0, y: angle, z: 0, duration: 0.5, usesShortestUnitArc: true)
                
                
                
                let distance = pow(pow(different.x, 2) + pow(different.y, 2) + pow(different.z, 2), 0.5)
                
                let duration = distance / Float(enemy.speed) * 20
                
                let displacementAction = SCNAction.move(to: enemy.path[i + 1], duration: TimeInterval(duration))
                
                
                let stepAction = SCNAction.group([rotationAction, displacementAction])
                
                
                actions.append(stepAction)
            }
            let sequenceActions = SCNAction.sequence(actions)
            enemy.enemyNode.runAction(sequenceActions)
        }
        
    }
    
    private func activateEnemies(enemies: Set<AnyEnemy>) {
        if intervalCounter  >= intervalBetweenEnemies {
            for enemy in enemies {
                if !enemy.isActive {
                    enemy.isActive = true
                    output.addNodeToScene(enemy.enemyNode)
                    intervalCounter = 0
                    runEnemies(enemies: [enemy])
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
    }
    
    private func runByNewPath(enemies: Set<AnyEnemy>) {
        runEnemies(enemies: enemies)
    }
    
    private func stopAllEnemies(enemies: Set<AnyEnemy>) {
        enemiesState = .inactive
        _ = enemies.map{$0.enemyNode.removeAllActions()
            EnemyAnimationManager.stopAnimation(for: $0)
        }
    }
    
    private func runAllEnemies(enemies: Set<AnyEnemy>) {
        _ = enemies.map{
            EnemyAnimationManager.resumeAnimation(for: $0)
        }
        enemiesState = .active
        runEnemies(enemies: enemies)
    }
    
}
