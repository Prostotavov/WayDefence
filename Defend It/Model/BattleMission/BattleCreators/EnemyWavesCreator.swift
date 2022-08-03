//
//  BattleMissionCreator.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.07.22.
//

import SceneKit

protocol EnemyWavesCreator {
    var enemiesWaves: [EnemiesWave] {get}
    func createWave(startFrame: Int)
    func addOneRaceWave(id: Int, race: EnemyRaces, level: EnemyLevels, count: Int, interval: Int, startFrame: Int)
    func setupEnemiesWaves()
}

protocol EnemyWavesCreatorDelegate: AnyObject {
    func enemyReachedCastle()
    func addNodeToScene(_ node: SCNNode)
}

final class EnemyWavesCreatorImpl: EnemyWavesCreator {
    var enemiesWaves: [EnemiesWave] = []
    weak var delegate: EnemyWavesCreatorDelegate!
    
    var size: Int
    
    init(size: Int) {
        self.size = size
    }
    
    func createWave(startFrame: Int) {
        let enemyWave = EnemiesWaveImpl(startFrame: startFrame, size: size)
        enemiesWaves.append(enemyWave)
    }
    
    func addOneRaceWave(id: Int, race: EnemyRaces, level: EnemyLevels, count: Int, interval: Int, startFrame: Int) {
        enemiesWaves[id].addOneRaceWave(race: race, level: level, count: count, intervalBetweenEnemies: interval, startFrame: startFrame)
    }
    
    func setupEnemiesWaves() {
        for enemyWave in enemiesWaves {
            enemyWave.setupDelegate(delegate: self)
        }
    }
}

extension EnemyWavesCreatorImpl: EnemiesWaveDelegate, OneEnemiesTypeWaveDelegate {
    func enemyReachedCastle() {
        delegate.enemyReachedCastle()
    }
    
    func addNodeToScene(_ node: SCNNode) {
        delegate.addNodeToScene(node)
    }
}
