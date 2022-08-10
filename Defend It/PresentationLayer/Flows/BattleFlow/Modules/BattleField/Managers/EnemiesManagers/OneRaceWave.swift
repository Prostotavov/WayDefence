//
//  OneRaceWave.swift
//  Defend It
//
//  Created by Роман Сенкевич on 1.07.22.
//

import SceneKit

protocol OneRaceWaveInput {
    
    func removeEnemy(_ enemy: AnyEnemy)
    func getEnemyBy(_ enemyNode: SCNNode) -> AnyEnemy?
    
    func removeEnemies()

    func enemyWounded(enemy: AnyEnemy)
    func sendEnemyMovementManager(command: EnemyMovementManagerCommands)
    
    var enemies: Set<AnyEnemy> {get}
    var startFrame: Int! {get}
}

protocol OneRaceWaveOutput: AnyObject {
    func enemyReachedCastle()
    func addNodeToScene(_ node: SCNNode)
}

class OneRaceWave: OneRaceWaveInput, EnemyMovementManagerOutput {

    var enemies = Set<AnyEnemy>()
    
    var enemyMovementManager: EnemyMovementManagerInput = EnemyMovementManager()
    
    weak var output: OneRaceWaveOutput!
    
    var startFrame: Int!
    
    init(race: EnemyRaces, level: EnemyLevels, count: Int, interval: Int, startFrame: Int) {
        self.startFrame = startFrame
        enemyMovementManager.setupManager(interval: interval, output: self)
        createEnemies(race: race, level: level, count: count)
        setupEnemies()
    }

    func createEnemies(race: EnemyRaces, level: EnemyLevels, count: Int) {
        for _ in 0..<count {
            create(race, with: level)
        }
    }
    
    func removeEnemies() {
        enemies.removeAll()
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

extension OneRaceWave {
    
    func addNodeToScene(_ node: SCNNode) {
        output.addNodeToScene(node)
    }

    func enemyReachedCastle(enemy: AnyEnemy) {
        removeEnemy(enemy)
        output.enemyReachedCastle()
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

