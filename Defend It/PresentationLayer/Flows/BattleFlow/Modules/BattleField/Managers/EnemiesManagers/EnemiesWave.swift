//
//  EnemiesWave.swift
//  Defend It
//
//  Created by Роман Сенкевич on 2.07.22.
//

import SceneKit

protocol EnemiesWaveDelegate: AnyObject {
    func enemyReachedCastle()
    func addNodeToScene(_ node: SCNNode)
}

protocol EnemiesWave {
    func removeEnemy(_ enemy: AnyEnemy)
    func updateCounter()
    func getEnemyBy(_ enemyNode: SCNNode) -> AnyEnemy?
    func removeEnemies()
    func addOneRaceWave(race: EnemyRaces, level: EnemyLevels, count: Int, intervalBetweenEnemies: Int, startFrame: Int)
    var startFrame: Int {get set}
    func enemyWounded(enemy: AnyEnemy)
    
    func setupDelegate(delegate: EnemiesWaveDelegate)
    var oneEnemiesTypeWaves: [OneEnemiesTypeWave] {get}
    
    func sendEnemyMovementManager(command: EnemyMovementManagerCommands)
}

class EnemiesWaveImpl: EnemiesWave, OneEnemiesTypeWaveDelegate {

    weak var delegate: EnemiesWaveDelegate!
    var oneEnemiesTypeWaves: [OneEnemiesTypeWave] = []
    var waveCounter: Int = 0
    var startFrame: Int
    
    init(startFrame: Int, size: Int) {
        self.startFrame = startFrame
    }
    
    func setupDelegate(delegate: EnemiesWaveDelegate) {
        self.delegate = delegate
    }
    
    func addOneRaceWave(race: EnemyRaces, level: EnemyLevels, count: Int, intervalBetweenEnemies: Int, startFrame: Int) {
        let oneRaceWave = OneEnemiesTypeWaveImpl(race: race, level: level, count: count, interval: intervalBetweenEnemies, startFrame: startFrame)
        oneRaceWave.delegate = self
        oneEnemiesTypeWaves.append(oneRaceWave)
    }
    
    func sendEnemyMovementManager(command: EnemyMovementManagerCommands) {
        for wave in oneEnemiesTypeWaves {
            if wave.getStartCounter() > waveCounter {continue}
            wave.sendEnemyMovementManager(command: command)
        }
    }
}

// funcs for oneRaceWave
extension EnemiesWaveImpl {
    
    
    func removeEnemy(_ enemy: AnyEnemy) {
        for wave in oneEnemiesTypeWaves {
            wave.removeEnemy(enemy)
        }
    }
    

    
    func updateCounter() {
        waveCounter += 1
        for wave in oneEnemiesTypeWaves {
            if wave.getStartCounter() > waveCounter {continue}
            if wave.getStartCounter() == waveCounter {wave.sendEnemyMovementManager(command: .runAllEnemies)}
            wave.sendEnemyMovementManager(command: .updateCounter)
        }
    }
    
    func removeEnemies() {
        for wave in oneEnemiesTypeWaves {
            if wave.getStartCounter() > waveCounter {continue}
            wave.removeEnemies()
        }
    }
    
    func getEnemyBy(_ enemyNode: SCNNode) -> AnyEnemy? {
        for wave in oneEnemiesTypeWaves {
            if wave.getStartCounter() > waveCounter {continue} ///  not a prerequisite. if it causes an error in the future, you can delete it
            if let enemy = wave.getEnemyBy(enemyNode) {
                return enemy
            }
        }
        return nil
    }
    
    func enemyWounded(enemy: AnyEnemy) {
        for wave in oneEnemiesTypeWaves {
            if wave.getStartCounter() > waveCounter {continue} ///  not a prerequisite. if it causes an error in the future, you can delete it
            wave.enemyWounded(enemy: enemy)
        }
    }
    
    func enemyReachedCastle() {
        delegate.enemyReachedCastle()
    }
    
    func addNodeToScene(_ node: SCNNode) {
        delegate.addNodeToScene(node)
    }
}

