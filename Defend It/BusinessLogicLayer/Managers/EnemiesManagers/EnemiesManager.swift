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
    func prohibitWalking(on coordinate: (Int, Int), byBuildingWith size: (Int, Int))
    func allowWalking(on coordinate: (Int, Int), byBuildingWith size: (Int, Int))
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
    var enemyWaveManager: EnemyWaveManager!
    
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
    
    func prohibitWalking(on coordinate: (Int, Int), byBuildingWith size: (Int, Int)) {
        EnemyPathManager.shared.prohibitWalking(on: coordinate, byBuildingWith: size)
        sendEnemyMovementManager(command: .runByNewPath)
    }
    
    func allowWalking(on coordinate: (Int, Int), byBuildingWith size: (Int, Int)) {
        EnemyPathManager.shared.allowWalking(on: coordinate, byBuildingWith: size)
        sendEnemyMovementManager(command: .runByNewPath)
    }
    
    func updateCounter() {
        wavesCounter += 1
        enemyWaveManager.update()
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
        iterateByActiveOneRaceWaves { oneRaceWave in
            oneRaceWave.sendEnemyMovementManager(command: command)
        }
    }
}
