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

    var enemyMovementManager: EnemyMovementManagerInput = EnemyMovementManager()
    var startFrame: Int!
    var enemies = Set<AnyEnemy>()
    weak var output: OneRaceWaveOutput!
    
    init(enemies: Set<AnyEnemy>, interval: Int, startFrame: Int) {
        self.startFrame = startFrame
        self.enemies = enemies
        enemyMovementManager.setupManager(interval: interval, output: self)
        setupEnemies()
    }
    
    //MARK: not here -start-
    
    func setupEnemies() {
        for enemy in enemies {
            enemy.enemyNode.position = EnemyPathManager.shared.culculateStartPosition()
            enemy.path = EnemyPathManager.shared.calculatePath(for: enemy)
        }
    }
    
    //MARK: not here -end-
    
    func removeEnemies() {
        enemies.removeAll()
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

