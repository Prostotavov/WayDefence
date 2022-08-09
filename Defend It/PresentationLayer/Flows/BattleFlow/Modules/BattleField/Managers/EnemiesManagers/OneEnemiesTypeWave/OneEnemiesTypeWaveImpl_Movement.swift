//
//  OneEnemiesTypeWaveImpl_Movement.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.08.22.
//

import SceneKit

extension OneEnemiesTypeWaveImpl {
    
    func activateEnemies() {
        if intervalCounter  >= intervalBetweenEnemies {
            for enemy in enemies {
                if !enemy.isActive {
                    enemy.isActive = true
                    delegate.addNodeToScene(enemy.enemyNode)
                    intervalCounter = 0
                    resetEnemyCounter()
                    pathCounter = 0
                    runEnemies()
                    return
                }
            }
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
    
    func prohibitWalking(On coordination: (Int, Int)) {
        resetEnemyCounter()
        pathCounter = 0
        enemyPositionManager.prohibitWalking(On: coordination)
        runEnemies()
    }
    
    func allowWalking(On coordination: (Int, Int)) {
        resetEnemyCounter()
        pathCounter = 0
        enemyPositionManager.allowWalking(On: coordination)
        runEnemies()
    }
    
    func stopAllEnemies() {
        enemiesState = .inactive
        resetEnemyCounter()
        pathCounter = 0
        enemies.map{$0.enemyNode.removeAllActions()}
    }
    
    func runAllEnemies() {
        enemiesState = .active
        resetEnemyCounter()
        pathCounter = 0
        runEnemies()
    }
    
    func runEnemies() {
        if enemiesState == .inactive {return}
        for enemy in enemies {
            let path = enemyPositionManager.calculatePath(for: enemy)
            enemy.setPath(path)
        }
    }
    
    func updateCounter() {
        
        if enemiesState == .inactive {return}
        intervalCounter += 1
        activateEnemies()
        
        // MARK: biggest bad practice in my code
        if pathCounter%5 == 0 { runEnemies()}
        
        for enemy in enemies {
            if !enemy.isActive {continue}
            if pathCounter == enemy.counter {
                if enemy.path.isEmpty {
                    enemyReachedCastle(enemy: enemy)
                    continue
                }
                let location = enemy.path.first!
                runOneSquare(enemy, to: location)
                enemy.path.removeFirst()
            }
        }
        pathCounter+=1
        // MARK: bad practice
        if pathCounter >= 99999 {
            pathCounter = 0
        }
    }
    
    func resetEnemyCounter() {
        for enemy in enemies {
            enemy.counter = 0
        }
    }
    
    func getDurationForStepAfterBuilding<T: Enemy>(for enemy: T) -> TimeInterval {
        let distination = Converter.toDistination(between: enemy.enemyNode.position, and: enemy.path.first!)
        let defaultDuration = Converter.toTimeInterval(from: enemy.speed)
        return  TimeInterval(defaultDuration * distination / 0.5)
    }
    
    func setupEnemies() {
        for enemy in enemies {
            enemy.enemyNode.position = enemyPositionManager.culculateStartPosition()
            enemy.path = enemyPositionManager.calculatePath(for: enemy)
        }
    }
}
