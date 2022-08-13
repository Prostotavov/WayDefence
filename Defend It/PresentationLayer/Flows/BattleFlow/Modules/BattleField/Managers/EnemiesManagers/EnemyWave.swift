//
//  EnemiesWave.swift
//  Defend It
//
//  Created by Роман Сенкевич on 2.07.22.
//

import SceneKit

protocol EnemyWaveInput {
    var startFrame: Int {get}
    var oneRaceWaves: [OneRaceWaveInput] {get}
    func addOneRaceWave(_ oneRaceWave: OneRaceWave)
}

class EnemyWave: EnemyWaveInput {
    
    var startFrame: Int
    var oneRaceWaves: [OneRaceWaveInput] = []

    init(startFrame: Int) {
        self.startFrame = startFrame
    }
    
    func addOneRaceWave(_ oneRaceWave: OneRaceWave) {
        oneRaceWaves.append(oneRaceWave)
    }
}

