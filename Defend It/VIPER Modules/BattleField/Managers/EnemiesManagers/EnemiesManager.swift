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
}

class EnemiesManagerImpl: EnemiesManager {
    var battleFieldSize: Int!
    var enemies = Set<AnyEnemy>()
    var enemyPositionManager: EnemyPositionManager!
    
    var timer: Timer?
    var counter: Int = 0
    
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
        }
    }
    
    func removeEnemy(_ enemy: AnyEnemy) {
        enemies.remove(enemy)
        if enemies.isEmpty {
            cancelTimer()
        }
    }
    
    private func runOneSquare(_ enemy: AnyEnemy, to location: SCNVector3) {
        var duration: TimeInterval
        if counter == 0 {
            duration = getDurationForStepAfterBuiling(for: enemy)
        } else {
            duration = Converter.toTimeInterval(from: enemy.speed)
        }
        enemy.counter += Converter.toCounter(from: duration)
        let action = SCNAction.move(to: location, duration: duration)
        enemy.enemyNode.removeAllActions()
        enemy.enemyNode.runAction(action)
    }
    
    func runEnemies() {
        for i in enemies.indices {
            let path = enemyPositionManager.calculatePath(for: enemies[i])
            enemies[i].setPath(path)
        }
        createTimer()
    }
    
    func prohibitWalking(On coordination: (Int, Int)) {
        counter = 0
        resetEnemyCounter()
        enemyPositionManager.prohibitWalking(On: coordination)
        if timer != nil { runEnemies() }
        
    }
    
    func allowWalking(On coordination: (Int, Int)) {
        counter = 0
        resetEnemyCounter()
        enemyPositionManager.allowWalking(On: coordination)
        if timer != nil { runEnemies() }
        
    }
}

extension EnemiesManagerImpl {
    
    func resetEnemyCounter() {
        for enemy in enemies {
            enemy.counter = 0
        }
    }
    
    func getDurationForStepAfterBuiling<T: Enemy>(for enemy: T) -> TimeInterval {
        let distination = Converter.toDistination(between: enemy.enemyNode.position, and: enemy.path!.first!)
        let defaultDuration = Converter.toTimeInterval(from: enemy.speed)
        return  TimeInterval(defaultDuration * distination / 0.5)
    }
    
    
    
    @objc func updateTimer() {

        for enemy in enemies {
            if counter == enemy.counter {
                
                if enemy.path!.isEmpty {
                    removeEnemy(enemy)
                    continue
                }
                let location = enemy.path!.first!
                runOneSquare(enemy, to: location)
                enemy.path?.removeFirst()
            }
        }
        counter+=1
        // MARK: bad practice
        if counter >= 9999 {
            counter = 0
        }
        
    }
    
    func createTimer() {
        if timer == nil {
            let timer = Timer(timeInterval: 0.1, target: self,
            selector: #selector(updateTimer), userInfo: nil, repeats: true)
            RunLoop.current.add(timer, forMode: .common)
            timer.tolerance = 0 // MARK: for high performance
            self.timer = timer
        }
    }
    
    func cancelTimer() {
        counter = 0
        timer?.invalidate()
        timer = nil
    }
}
