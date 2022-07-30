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
    func prohibitWalking(On coordination: (Int, Int))
    func allowWalking(On coordination: (Int, Int))
    func updateCounter()
    func getEnemyBy(_ enemyNode: SCNNode) -> AnyEnemy?
    func removeEnemies()
    func stopAllEnemies()
    func runAllEnemies()
    func addEnemiesToScene()
    func addOneRaceWave(race: EnemyRaces, level: EnemyLevels, count: Int, intervalBetweenEnemies: Int, startFrame: Int)
    var startFrame: Int {get set}
    
    func setupDelegate(delegate: EnemiesWaveDelegate)
    var oneEnemiesTypeWaves: [OneEnemiesTypeWave] {get}
}

class EnemiesWaveImpl: EnemiesWave, OneEnemiesTypeWaveDelegate {

    weak var delegate: EnemiesWaveDelegate!
    var oneEnemiesTypeWaves: [OneEnemiesTypeWave] = []
    var waveCounter: Int = 0
    var startFrame: Int
    
    init(startFrame: Int) {
        self.startFrame = startFrame
    }
    
    func setupDelegate(delegate: EnemiesWaveDelegate) {
        self.delegate = delegate
    }
    
    func addOneRaceWave(race: EnemyRaces, level: EnemyLevels, count: Int, intervalBetweenEnemies: Int, startFrame: Int) {
        let oneRaceWave = OneEnemiesTypeWaveImpl(7, race: race, level: level, count: count, interval: intervalBetweenEnemies, startFrame: startFrame)
        oneRaceWave.delegate = self
        oneEnemiesTypeWaves.append(oneRaceWave)
    }
}

// funcs for oneRaceWave
extension EnemiesWaveImpl {
    
    
    func removeEnemy(_ enemy: AnyEnemy) {
        for wave in oneEnemiesTypeWaves {
            wave.removeEnemy(enemy)
        }
    }
    
    func prohibitWalking(On coordination: (Int, Int)) {
        for wave in oneEnemiesTypeWaves {
            wave.prohibitWalking(On: coordination)
        }
    }
    
    func allowWalking(On coordination: (Int, Int)) {
        for wave in oneEnemiesTypeWaves {
            wave.allowWalking(On: coordination)
        }
    }
    
    func updateCounter() {
        waveCounter += 1
        for wave in oneEnemiesTypeWaves {
            if wave.getStartCounter() > waveCounter {continue}
            if wave.getStartCounter() == waveCounter {wave.runAllEnemies()}
            wave.updateCounter()
        }
    }
    
    func removeEnemies() {
        for wave in oneEnemiesTypeWaves {
            if wave.getStartCounter() > waveCounter {continue}
            wave.removeEnemies()
        }
    }
    
    func stopAllEnemies() {
        for wave in oneEnemiesTypeWaves {
            if wave.getStartCounter() > waveCounter {continue}
            wave.stopAllEnemies()
        }
    }
    
    func runAllEnemies() {
        for wave in oneEnemiesTypeWaves {
            if wave.getStartCounter() > waveCounter {continue}
            wave.runAllEnemies()
        }
    }
    
    func addEnemiesToScene() {
        for wave in oneEnemiesTypeWaves {
            if wave.getStartCounter() > waveCounter {continue}
            wave.addEnemiesToScene()
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
    
    func enemyReachedCastle() {
        delegate.enemyReachedCastle()
    }
    
    func addNodeToScene(_ node: SCNNode) {
        delegate.addNodeToScene(node)
    }
}

