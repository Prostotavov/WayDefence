//
//  EnemyWaveManager.swift
//  Defend It
//
//  Created by Роман Сенкевич on 13.08.22.
//

import Foundation

class EnemyWaveManager {
    
    var wavesCounter: Int = 0
    
    @Weak var enemyWaves: [EnemyWave]
    
    init(enemyWaves: [EnemyWaveInput]) {
        self.enemyWaves = enemyWaves as! [EnemyWave]
    }
    
    func update() {
        wavesCounter += 1
        for wave in enemyWaves {
            for oneRaceWave in wave.oneRaceWaves {
                if oneRaceWave.startFrame == (wavesCounter - wave.startFrame) {
                    oneRaceWave.sendEnemyMovementManager(command: .runAllEnemies)
                }
                oneRaceWave.sendEnemyMovementManager(command: .updateCounter)

            }
        }
    }
    
    
}
