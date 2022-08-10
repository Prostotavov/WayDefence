//
//  OneEnemiesType.swift
//  Defend It
//
//  Created by Роман Сенкевич on 1.07.22.
//

import SceneKit

protocol OneEnemiesTypeWave {
    func removeEnemy(_ enemy: AnyEnemy)
    func getEnemyBy(_ enemyNode: SCNNode) -> AnyEnemy?
    func removeEnemies()
    func getStartCounter() -> Int
    var enemies: Set<AnyEnemy> {get}
    func enemyWounded(enemy: AnyEnemy)
    func sendEnemyMovementManager(command: EnemyMovementManagerCommands)
}

protocol OneEnemiesTypeWaveDelegate: AnyObject {
    func enemyReachedCastle()
    func addNodeToScene(_ node: SCNNode)
}

class OneEnemiesTypeWaveImpl: OneEnemiesTypeWave, EnemyMovementManagerOutput {

    var enemies = Set<AnyEnemy>()
    
    var enemyMovementManager: EnemyMovementManagerInput = EnemyMovementManager()
    
    weak var delegate: OneEnemiesTypeWaveDelegate!
    
    var race: EnemyRaces!
    var level: EnemyLevels!
    var countOfEnemies: Int!
    
    var startFrame: Int!
    
    init(race: EnemyRaces, level: EnemyLevels, count: Int, interval: Int, startFrame: Int) {
        self.race = race
        self.level = level
        self.countOfEnemies = count
        self.startFrame = startFrame
        enemyMovementManager.setupManager(interval: interval, output: self)
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
    
    func setupEnemies() {
        for enemy in enemies {
            enemy.enemyNode.position = EnemyPathManager.shared.culculateStartPosition()
            enemy.path = EnemyPathManager.shared.calculatePath(for: enemy)
        }
    }

}

extension OneEnemiesTypeWaveImpl {
    
    func addNodeToScene(_ node: SCNNode) {
        delegate.addNodeToScene(node)
    }

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
    
    func sendEnemyMovementManager(command: EnemyMovementManagerCommands) {
        enemyMovementManager.execute(command: command, for: enemies)
    }
}

