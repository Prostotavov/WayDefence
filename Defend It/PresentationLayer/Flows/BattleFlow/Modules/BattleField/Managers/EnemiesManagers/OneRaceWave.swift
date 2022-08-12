//
//  OneRaceWave.swift
//  Defend It
//
//  Created by Роман Сенкевич on 1.07.22.
//

import SceneKit

protocol OneRaceWaveInput {
    
    func removeEnemy(_ enemy: AnyEnemy)
    func sendEnemyMovementManager(command: EnemyMovementManagerCommands)
    
    var enemies: Set<AnyEnemy> {get}
    var startFrame: Int! {get}
    func setupDelegate(delegate: OneRaceWaveOutput)
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
    }
    
    func setupDelegate(delegate: OneRaceWaveOutput) {
        self.output = delegate
    }
    
    func removeEnemy(_ enemy: AnyEnemy) {
        enemy.enemyNode.removeFromParentNode()
        enemies.remove(enemy)
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
    
    func sendEnemyMovementManager(command: EnemyMovementManagerCommands) {
        enemyMovementManager.execute(command: command, for: enemies)
    }
}

