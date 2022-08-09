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
    func getStartCounter() -> Int
    var enemies: Set<AnyEnemy> {get}
    
    func enemyWounded(enemy: AnyEnemy)
}

protocol OneEnemiesTypeWaveDelegate: AnyObject {
    func enemyReachedCastle()
    func addNodeToScene(_ node: SCNNode)
}

class OneEnemiesTypeWaveImpl: OneEnemiesTypeWave {

    var battleFieldSize: Int!
    var enemies = Set<AnyEnemy>()
    var enemyPositionManager: EnemyPathManager!
    
    var pathCounter: Int = 0
    var enemiesState: EnemiesStates!
    
    weak var delegate: OneEnemiesTypeWaveDelegate!
    
    var race: EnemyRaces!
    var level: EnemyLevels!
    let intervalBetweenEnemies: Int!
    var intervalCounter: Int!
    var countOfEnemies: Int!
    
    var startFrame: Int!
    
    init(_ battleFieldSize: Int, race: EnemyRaces, level: EnemyLevels, count: Int, interval: Int, startFrame: Int) {
        self.battleFieldSize = battleFieldSize
        self.race = race
        self.level = level
        self.countOfEnemies = count
        self.intervalBetweenEnemies = interval
        self.intervalCounter = interval
        self.startFrame = startFrame
        enemiesState = .inactive
        createEnemies()
        setupEnemies()
    }

    func createEnemies() {
        for _ in 0..<countOfEnemies {
            create(race, with: level)
        }
    }
    
    func removeEnemies() {
        enemies.removeAll()
    }
    
    func getStartCounter() -> Int {
        startFrame
    }
    
    func create(_ rase: EnemyRaces, with level: EnemyLevels) {
        let enemy = AbstractFactoryEnemiesImpl.defaultFactory.create(rase, with: level)
        EnemyPhysicsManager.addPhysicsBody(for: enemy)
        EnemyHealthBarManager.addHealthProgressBar(for: enemy)
        enemies.insert(enemy)
    }
    
    func removeEnemy(_ enemy: AnyEnemy) {
        enemy.enemyNode.removeFromParentNode()
        enemies.remove(enemy)
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

extension OneEnemiesTypeWaveImpl {

    func enemyReachedCastle(enemy: AnyEnemy) {
        enemy.enemyNode.removeFromParentNode()
        removeEnemy(enemy)
        delegate.enemyReachedCastle()
    }
    
    func enemyWounded(enemy: AnyEnemy) {
        for _enemy in enemies {
            if _enemy.id.uuidString == enemy.enemyNode.name {
                EnemyHealthBarManager.updateHealthProgressBar(for: enemy)
            }
        }
    }
}

