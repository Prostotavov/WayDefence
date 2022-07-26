//
//  OneEnemiesType.swift
//  Defend It
//
//  Created by Роман Сенкевич on 1.07.22.
//

import SceneKit

protocol OneEnemiesTypeWave {
    func removeEnemy(_ enemy: AnyEnemy)
    func prohibitWalking(On coordination: (Int, Int))
    func allowWalking(On coordination: (Int, Int))
    func updateCounter()
    func getEnemyBy(_ enemyNode: SCNNode) -> AnyEnemy?
    func removeEnemies()
    func stopAllEnemies()
    func runAllEnemies()
    func addEnemiesToScene()
    func getStartCounter() -> Int
    var enemies: Set<AnyEnemy> {get}
}

protocol OneEnemiesTypeWaveDelegate: AnyObject {
    func enemyReachedCastle()
    func addNodeToScene(_ node: SCNNode)
}

class OneEnemiesTypeWaveImpl: OneEnemiesTypeWave {

    var battleFieldSize: Int!
    var enemies = Set<AnyEnemy>()
    var enemyPositionManager: EnemyPositionManager!
    
    var pathCounter: Int = 0
    var enemiesState: EnemiesStates!
    
    weak var delegate: OneEnemiesTypeWaveDelegate!
    
    var race: EnemyRaces!
    var level: EnemyLevels!
    let intervalBetweenEnemies: Int!
    var intervalCounter: Int!
    var countOfEnemies: Int!
    
    var startFrame: Int!
    
    func getStartCounter() -> Int {
        startFrame
    }
    
    init(_ battleFieldSize: Int, race: EnemyRaces, level: EnemyLevels, count: Int, interval: Int, startFrame: Int) {
        self.battleFieldSize = battleFieldSize
        self.race = race
        self.level = level
        self.countOfEnemies = count
        self.intervalBetweenEnemies = interval
        self.intervalCounter = interval
        self.startFrame = startFrame
        enemiesState = .inactive
        enemyPositionManager = EnemyPositionManagerImpl(battleFieldSize)
        createEnemies()
        setupEnemies()
    }
    
    
    
    func addEnemiesToScene() {
        for enemy in enemies {
            delegate.addNodeToScene(enemy.enemyNode)
        }
    }
    
    func removeEnemies() {
        enemies.removeAll()
    }
    
    func createEnemies() {
        for _ in 0..<countOfEnemies {
            create(race, with: level)
        }
    }
    
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
}

extension OneEnemiesTypeWaveImpl {
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
    
    
    func getEnemyBy(_ enemyNode: SCNNode) -> AnyEnemy? {
        for enemy in enemies {
            if enemy.id.uuidString == enemyNode.name {
                return enemy
            }
        }
        return nil
    }
    
}
