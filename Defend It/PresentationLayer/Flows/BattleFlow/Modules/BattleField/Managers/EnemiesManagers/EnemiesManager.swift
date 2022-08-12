//
//  EnemiesManager.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import SceneKit

enum EnemiesStates {
    case active
    case inactive
}

protocol EnemiesManager {
    
    func removeEnemy(_ enemy: AnyEnemy)
    func prohibitWalking(On coordination: (Int, Int))
    func allowWalking(On coordination: (Int, Int))
    func updateCounter()
    func getEnemyBy(_ enemyNode: SCNNode) -> AnyEnemy?
    func stopAllEnemies()
    func runAllEnemies()
    func enemyWounded(enemy: AnyEnemy)
    
}

protocol EnemiesManagerOutput: AnyObject {
    func enemyReachedCastle()
    func addNodeToScene(_ node: SCNNode)
    func getBattleCounter() -> Int
}

class EnemiesManagerImpl: EnemiesManager, OneRaceWaveOutput {
    
    var enemiesState: EnemiesStates!
    weak var output: EnemiesManagerOutput!
    var enemyWaves: [EnemyWaveInput]!
    var wavesCounter: Int = 0

    func setupDelegates() {
        iterateByOneRaceWaves { oneRaceWave in
            oneRaceWave.setupDelegate(delegate: self)
        }
    }
    
    func enemyReachedCastle() {
        output.enemyReachedCastle()
    }
    
    func addNodeToScene(_ node: SCNNode) {
        output.addNodeToScene(node)
    }
    
    func removeEnemy(_ enemy: AnyEnemy) {
        iterateByOneRaceWaves { oneRaceWave in
            oneRaceWave.removeEnemy(enemy)
        }
    }

    func prohibitWalking(On coordination: (Int, Int)) {
        EnemyPathManager.shared.prohibitWalking(On: coordination)
        sendEnemyMovementManager(command: .runByNewPath)
    }
    
    func allowWalking(On coordination: (Int, Int)) {
        EnemyPathManager.shared.allowWalking(On: coordination)
        sendEnemyMovementManager(command: .runByNewPath)
    }
    
    func updateCounter() {
        wavesCounter += 1
        iterateByActiveWaves { wave in
            if wave.startFrame == wavesCounter {
                wave.sendEnemyMovementManager(command: .runAllEnemies)
            }
            wave.updateCounter()
        }
    }
    
    func getEnemyBy(_ enemyNode: SCNNode) -> AnyEnemy? {
        var enemy: AnyEnemy?
        iterateByEnemies { currentEnemy in
            if currentEnemy.id.uuidString == enemyNode.name {
                enemy = currentEnemy
                return
            }
        }
        return enemy
    }
    
    func enemyWounded(enemy: AnyEnemy) {
        iterateByEnemies { currentEnemy in
            if currentEnemy.id.uuidString == enemy.enemyNode.name {
                EnemyHealthBarManager.updateHealthProgressBar(for: enemy)
                return
            }
        }
    }
    
    func stopAllEnemies() {
        sendEnemyMovementManager(command: .stopAllEnemies)
    }
    
    func runAllEnemies() {
        sendEnemyMovementManager(command: .runAllEnemies)
    }
    
    private func sendEnemyMovementManager(command: EnemyMovementManagerCommands) {
        iterateByActiveWaves { wave in
            wave.sendEnemyMovementManager(command: command)
        }
    }
}
