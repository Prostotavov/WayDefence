//
//  OneEnemiesTypeWaveImpl_Movement.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.08.22.
//

import SceneKit

extension OneEnemiesTypeWaveImpl {
    
    func activateEnemies() {
        if enemyMovementManager.intervalCounter  >= intervalBetweenEnemies {
            for enemy in enemies {
                if !enemy.isActive {
                    enemy.isActive = true
                    delegate.addNodeToScene(enemy.enemyNode)
                    enemyMovementManager.intervalCounter = 0
                    resetEnemyCounter()
                    enemyMovementManager.pathCounter = 0
                    enemyMovementManager.runEnemies(enemies: enemies)
                    return
                }
            }
        }
    }
    
    
    // not here -start-
    func updateCounter() {
        if enemyMovementManager.enemiesState == .inactive {return}
        enemyMovementManager.intervalCounter += 1
        activateEnemies()
        
        // MARK: biggest bad practice in my code
        if enemyMovementManager.pathCounter%5 == 0 { enemyMovementManager.runEnemies(enemies: enemies)}
        
        for enemy in enemies {
            if !enemy.isActive {continue}
            if enemyMovementManager.pathCounter == enemy.counter {
                if enemy.path.isEmpty {
                    enemyReachedCastle(enemy: enemy)
                    continue
                }
                let location = enemy.path.first!
                enemyMovementManager.runOneSquare(enemy, to: location)
                enemy.path.removeFirst()
            }
        }
        enemyMovementManager.pathCounter += 1
        // MARK: bad practice
        if enemyMovementManager.pathCounter >= 99999 {
            enemyMovementManager.pathCounter = 0
        }
    }
    
    // not here -end-
    
    func prohibitWalking(On coordination: (Int, Int)) {
        resetEnemyCounter()
        enemyMovementManager.pathCounter = 0
        enemyMovementManager.runEnemies(enemies: enemies)
    }
    
    func allowWalking(On coordination: (Int, Int)) {
        resetEnemyCounter()
        enemyMovementManager.pathCounter = 0
        enemyMovementManager.runEnemies(enemies: enemies)
    }
    
    func stopAllEnemies() {
        enemyMovementManager.enemiesState = .inactive
        resetEnemyCounter()
        enemyMovementManager.pathCounter = 0
        _ = enemies.map{$0.enemyNode.removeAllActions()}
    }
    
    func runAllEnemies() {
        enemyMovementManager.enemiesState = .active
        resetEnemyCounter()
        enemyMovementManager.pathCounter = 0
        enemyMovementManager.runEnemies(enemies: enemies)
    }
    
    
    
    func resetEnemyCounter() {
        for enemy in enemies {
            enemy.counter = 0
        }
    }
    
    
    
    func setupEnemies() {
        for enemy in enemies {
            enemy.enemyNode.position = EnemyPathManager.shared.culculateStartPosition()
            enemy.path = EnemyPathManager.shared.calculatePath(for: enemy)
        }
    }
}
