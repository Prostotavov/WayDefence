//
//  EnemiesManager.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import SceneKit

protocol EnemiesManager {
    
    var enemies: Set<AnyEnemy> {get}
    func removeEnemy(_ enemy: AnyEnemy)
    func prohibitWalking(On coordination: (Int, Int))
    func allowWalking(On coordination: (Int, Int))
    func updateCounter()
    func getEnemyBy(_ enemyNode: SCNNode) -> AnyEnemy?
    func removeEnemies()
    func stopAllEnemies()
    func runAllEnemies()
}

protocol EnemiesManagerDelegate: AnyObject {
    func enemyReachedCastle()
}

class EnemiesManagerImpl: EnemiesManager {
    var battleFieldSize: Int!
    var enemies = Set<AnyEnemy>()
    var enemyPositionManager: EnemyPositionManager!
    
    var counter: Int = 0
    var isRun: Bool = false
    
    var delegate: EnemiesManagerDelegate!
    
    init(_ battleFieldSize: Int) {
        self.battleFieldSize = battleFieldSize
        enemyPositionManager = EnemyPositionManagerImpl(battleFieldSize)
        createEnemies()
        setupEnemies()
    }
    
    func removeEnemies() {
        enemies.removeAll()
    }
    
    func createEnemies() {
        for _ in 0..<5 {
            create(.orc, with: .firstLevel)
            create(.troll, with: .firstLevel)
            create(.goblin, with: .firstLevel)

            create(.orc, with: .secondLevel)
            create(.troll, with: .secondLevel)
            create(.goblin, with: .secondLevel)

            create(.orc, with: .thirdLevel)
            create(.troll, with: .thirdLevel)
            create(.goblin, with: .thirdLevel)
        }
    }
    
    func create(_ rase: EnemyRaces, with level: EnemyLevels) {
        let enemy = AbstractFactoryEnemiesImpl.defaultFactory.create(rase, with: level)
        addPhysicsBody(for: enemy)
        enemies.insert(enemy)
    }
    
    func addPhysicsBody(for enemy: AnyEnemy) {
        let radius = 0.1
        let physicsShape = SCNPhysicsShape(geometry: SCNSphere(radius: radius))
        let physicsBody = SCNPhysicsBody(type: .kinematic, shape: physicsShape)
        physicsBody.isAffectedByGravity = false
        physicsBody.categoryBitMask = 2
        enemy.enemyNode.physicsBody = physicsBody
    }
    
    func setupEnemies() {
        for enemy in enemies {
            enemy.enemyNode.position = enemyPositionManager.culculateStartPosition()
            enemy.path = enemyPositionManager.calculatePath(for: enemy)
        }
    }
    
    func removeEnemy(_ enemy: AnyEnemy) {
        enemy.enemyNode.removeFromParentNode()
        enemies.remove(enemy)
    }
    
    private func runOneSquare(_ enemy: AnyEnemy, to location: SCNVector3) {
        var duration: TimeInterval
        if counter == 0 {
            duration = getDurationForStepAfterBuilding(for: enemy)
        } else {
            duration = Converter.toTimeInterval(from: enemy.speed)
        }
        enemy.counter += Converter.toCounter(from: duration)
        let action = SCNAction.move(to: location, duration: duration)
        !enemy.enemyNode.actionKeys.isEmpty ? print("-0-") : print("evr alr")
        enemy.enemyNode.removeAllActions()
        enemy.enemyNode.runAction(action)
    }
    
    func prohibitWalking(On coordination: (Int, Int)) {
        resetEnemyCounter()
        counter = 0
        enemyPositionManager.prohibitWalking(On: coordination)
        runEnemies()
    }
    
    func allowWalking(On coordination: (Int, Int)) {
        resetEnemyCounter()
        counter = 0
        enemyPositionManager.allowWalking(On: coordination)
        runEnemies()
    }
    
    func stopAllEnemies() {
        isRun = false
        resetEnemyCounter()
        counter = 0
        enemies.map{$0.enemyNode.removeAllActions()}
    }
    
    func runAllEnemies() {
        isRun = true
        resetEnemyCounter()
        counter = 0
        runEnemies()
    }
    
    func runEnemies() {
        if !isRun {return}
        for enemy in enemies {
            let path = enemyPositionManager.calculatePath(for: enemy)
            enemy.setPath(path)
        }
    }

}

extension EnemiesManagerImpl {
    
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
    
    func enemyReachedCastle(enemy: AnyEnemy) {
        enemy.enemyNode.removeFromParentNode()
        removeEnemy(enemy)
        delegate.enemyReachedCastle()
    }
    
    func updateCounter() {
        
        if !isRun {return}
        
        // MARK: biggest bad practice in my code
        if counter%5 == 0 { runEnemies()}
        
        for enemy in enemies {
            if counter == enemy.counter {
                if enemy.path.isEmpty {
                    enemyReachedCastle(enemy: enemy)
                    continue
                }
                let location = enemy.path.first!
                runOneSquare(enemy, to: location)
                enemy.path.removeFirst()
            }
        }
        counter+=1
        // MARK: bad practice
        if counter >= 99999 {
            counter = 0
        }
    }
    
}

extension EnemiesManagerImpl {
    
    func getEnemyBy(_ enemyNode: SCNNode) -> AnyEnemy? {
        for enemy in enemies {
            if enemy.id.uuidString == enemyNode.name {
                return enemy
            }
        }
        return enemies.first
    }
}

