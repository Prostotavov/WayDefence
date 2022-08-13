//
//  BattleMission.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.07.22.
//

import SceneKit

protocol BattleMission {
    
    var countOfEnemies: Int {get set}
    
    var battleFieldSize: Int {get set}
    
    var enemies: [EnemyWaveInput] {get set}
    var meadow: BattleMeadow {get set}
    var battleValues: BattleMissionValues {get set}
}

class BattleMissionImp: BattleMission {
    
    var battleFieldSize: Int
    var countOfEnemies: Int = 0

    var enemies: [EnemyWaveInput]
    var meadow: BattleMeadow
    var battleValues: BattleMissionValues
    
    internal init(enemies: [EnemyWaveInput], meadow: BattleMeadow, battleValues: BattleMissionValues) {
        self.meadow = meadow
        self.enemies = enemies
        self.battleValues = battleValues
        
        battleFieldSize = meadow.size

        
        calculateEnemies()
    }
    
    func calculateEnemies() {
        for enemyWave in enemies {
            for oneRaceWave in enemyWave.oneRaceWaves {
                countOfEnemies += oneRaceWave.enemies.count
            }
        }
    }
    
}




