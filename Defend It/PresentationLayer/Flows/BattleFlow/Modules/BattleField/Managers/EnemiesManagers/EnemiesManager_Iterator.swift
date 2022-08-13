//
//  EnemiesManager_Iterator.swift
//  Defend It
//
//  Created by Роман Сенкевич on 13.08.22.
//

import Foundation

extension EnemiesManagerImpl {
    
    func iterateByEnemies(completion: (_ enemy: AnyEnemy) -> Void) {
        iterateByOneRaceWaves { oneRaceWave in
            for enemy in oneRaceWave.enemies {
                completion(enemy)
            }
        }
    }
    
    func iterateByOneRaceWaves(completion: (_ oneRaceWave: OneRaceWaveInput) -> Void) {
        iterateByWaves { wave in
            for oneRaceWave in wave.oneRaceWaves {
                completion(oneRaceWave)
            }
        }
    }
    
    func iterateByWaves(completion: (_ wave: EnemyWaveInput) -> Void) {
        for wave in enemyWaves {
            completion(wave)
        }
    }
    
    func iterateByActiveOneRaceWaves(completion: (_ oneRaceWave: OneRaceWaveInput) -> Void) {
        iterateByActiveWaves { wave in
            for oneRaceWave in wave.oneRaceWaves {
                completion(oneRaceWave)
            }
        }
    }
    
    func iterateByActiveWaves(completion: (_ wave: EnemyWaveInput) -> Void) {
        for wave in enemyWaves {
            if wave.startFrame > wavesCounter {continue}
            completion(wave)
        }
    }
}
