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
}


final class EnemyWavesCreatorImpl: EnemyWavesCreator {
    var enemiesWaves: [EnemiesWave] = []
    
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
}
