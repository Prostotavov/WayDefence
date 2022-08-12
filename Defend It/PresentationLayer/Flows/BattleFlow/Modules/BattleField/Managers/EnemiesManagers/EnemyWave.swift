//
//  EnemiesWave.swift
//  Defend It
//
//  Created by Роман Сенкевич on 2.07.22.
//

import SceneKit

protocol EnemyWaveInput {
    func updateCounter()
    var startFrame: Int {get}
    var oneRaceWaves: [OneRaceWaveInput] {get}
    func addOneRaceWave(_ oneRaceWave: OneRaceWave)
    
    func sendEnemyMovementManager(command: EnemyMovementManagerCommands)
}

class EnemyWave: EnemyWaveInput {
    
    var oneRaceWaves: [OneRaceWaveInput] = []
    
    var waveCounter: Int = 0
    var startFrame: Int
    
    init(startFrame: Int) {
        self.startFrame = startFrame
    }
    
    func addOneRaceWave(_ oneRaceWave: OneRaceWave) {
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
    
    func updateCounter(){
        waveCounter += 1
        for oneRaceWave in oneRaceWaves {
            if oneRaceWave.startFrame > waveCounter {continue}
            if oneRaceWave.startFrame == waveCounter {oneRaceWave.sendEnemyMovementManager(command: .runAllEnemies)}
            oneRaceWave.sendEnemyMovementManager(command: .updateCounter)
        }
    }
}

