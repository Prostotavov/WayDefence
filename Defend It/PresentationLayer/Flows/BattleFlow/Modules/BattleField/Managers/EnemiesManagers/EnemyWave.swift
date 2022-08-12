//
//  EnemiesWave.swift
//  Defend It
//
//  Created by Роман Сенкевич on 2.07.22.
//

import SceneKit

protocol EnemyWaveInput {
    func removeEnemy(_ enemy: AnyEnemy)
    func updateCounter()
    func getEnemyBy(_ enemyNode: SCNNode) -> AnyEnemy?
    func removeEnemies()
    var startFrame: Int {get set}
    func enemyWounded(enemy: AnyEnemy)
    
    func setupDelegate(delegate: EnemyWaveOutput)
    var oneRaceWaves: [OneRaceWaveInput] {get}
    func addOneRaceWave(_ oneRaceWave: OneRaceWave)
    
    func sendEnemyMovementManager(command: EnemyMovementManagerCommands)
}

protocol EnemyWaveOutput: AnyObject {
    func enemyReachedCastle()
    func addNodeToScene(_ node: SCNNode)
}

class EnemyWave: EnemyWaveInput, OneRaceWaveOutput {

    weak var delegate: EnemyWaveOutput!
    var oneRaceWaves: [OneRaceWaveInput] = []
    
    var waveCounter: Int = 0
    var startFrame: Int
    
    var enemyCreationManager: EnemyCreationManager = EnemyCreationManager()
    
    init(startFrame: Int) {
        self.startFrame = startFrame
    }
    
    func setupDelegate(delegate: EnemyWaveOutput) {
        self.delegate = delegate
    }
    
    func addOneRaceWave(_ oneRaceWave: OneRaceWave) {
        oneRaceWave.output = self
        oneRaceWaves.append(oneRaceWave)
    }
    
    func sendEnemyMovementManager(command: EnemyMovementManagerCommands) {
        for oneRaceWave in oneRaceWaves {
            if oneRaceWave.startFrame > waveCounter {continue}
            oneRaceWave.sendEnemyMovementManager(command: command)
        }
    }
}

// funcs for oneRaceWave
extension EnemyWave {
    
    func removeEnemy(_ enemy: AnyEnemy) {
        for oneRaceWave in oneRaceWaves {
            oneRaceWave.removeEnemy(enemy)
        }
    }
    
    func updateCounter(){
        waveCounter += 1
        for oneRaceWave in oneRaceWaves {
            if oneRaceWave.startFrame > waveCounter {continue}
            if oneRaceWave.startFrame == waveCounter {oneRaceWave.sendEnemyMovementManager(command: .runAllEnemies)}
            oneRaceWave.sendEnemyMovementManager(command: .updateCounter)
        }
    }
    
    func removeEnemies() {
        for oneRaceWave in oneRaceWaves {
            if oneRaceWave.startFrame > waveCounter {continue}
            oneRaceWave.removeEnemies()
        }
    }
    
    func getEnemyBy(_ enemyNode: SCNNode) -> AnyEnemy? {
        for oneRaceWave in oneRaceWaves {
            if oneRaceWave.startFrame > waveCounter {continue} ///  not a prerequisite. if it causes an error in the future, you can delete it
            if let enemy = oneRaceWave.getEnemyBy(enemyNode) {
                return enemy
            }
        }
        return nil
    }
    
    func enemyWounded(enemy: AnyEnemy) {
        for oneRaceWave in oneRaceWaves {
            if oneRaceWave.startFrame > waveCounter {continue} ///  not a prerequisite. if it causes an error in the future, you can delete it
            oneRaceWave.enemyWounded(enemy: enemy)
        }
    }
    
    func enemyReachedCastle() {
        delegate.enemyReachedCastle()
    }
    
    func addNodeToScene(_ node: SCNNode) {
        delegate.addNodeToScene(node)
    }
}

