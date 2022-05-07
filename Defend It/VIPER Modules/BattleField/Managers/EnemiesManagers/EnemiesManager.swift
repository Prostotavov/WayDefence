//
//  EnemiesManager.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import SceneKit

protocol EnemiesManager {
    
    var enemies: Set<AnyEnemy> {get}
    func runEnemies()
    func prohibitWalking(On coordination: (Int, Int))
    func allowWalking(On coordination: (Int, Int))
    func updateCounter()
}

class EnemiesManagerImpl: EnemiesManager {
    var battleFieldSize: Int!
    var enemies = Set<AnyEnemy>()
    var enemyPositionManager: EnemyPositionManager!
    
    var counter: Int = 0
    var isRun: Bool = false
    
    init(_ battleFieldSize: Int) {
        self.battleFieldSize = battleFieldSize
        enemyPositionManager = EnemyPositionManagerImpl(battleFieldSize)
        createEnemies()
        setupEnemies()
    }
    
    func createEnemies() {
        create(.orc, with: .firstLevel)
        create(.troll, with: .firstLevel)
        create(.goblin, with: .firstLevel)
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
        enemy.enemyNode.removeAllActions()
        print("runOneSquare")
        enemy.enemyNode.runAction(action)
    }
    
    func runEnemies() {
        for i in enemies.indices {
            let path = enemyPositionManager.calculatePath(for: enemies[i])
            enemies[i].setPath(path)
        }
    }
    
    func prohibitWalking(On coordination: (Int, Int)) {
        counter = 0
        resetEnemyCounter()
        enemyPositionManager.prohibitWalking(On: coordination)
        runEnemies()
    }
    
    func allowWalking(On coordination: (Int, Int)) {
        counter = 0
        resetEnemyCounter()
        enemyPositionManager.allowWalking(On: coordination)
        runEnemies()
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
    
    func updateCounter() {
        
        // MARK: so mach bad practice
        
        if counter == 299 {
            if !isRun {counter = 0}
            isRun = true
            
        }
        
        if !isRun {
            counter+=1
            return
        }
        
        print(counter)
        
        for enemy in enemies {
            if counter == enemy.counter {
                if enemy.path.isEmpty {
                    removeEnemy(enemy)
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
