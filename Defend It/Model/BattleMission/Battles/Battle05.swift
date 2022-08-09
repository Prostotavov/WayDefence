//
//  Battle05.swift
//  Defend It
//
//  Created by Роман Сенкевич on 3.08.22.
//

import SceneKit

final class Battle05: BattleMission {
    var id: Int = 4
    
    var battleFieldSize: Int = 9
    var countOfEnemies: Int = 0
    
    var battleMeadow: BattleMeadow
    var enemiesWaves: [EnemiesWave] = []
    var battleValues: BattleValues
    
    var wavesCreator: EnemyWavesCreatorImpl
    var meadowCreator: BattleMeadowCreator
    
    init() {
        
        wavesCreator = EnemyWavesCreatorImpl(size: battleFieldSize)
        
        meadowCreator = BattleMeadowCreatorImpl(size: battleFieldSize)
        
        battleMeadow = BattleMeadowImpl(size: battleFieldSize)
        battleValues = BattleValuesImpl()
        createMeadow()
        createWave()
        setupBattleValues()
        calculateEnemies()
    }
    
    func createMeadow() {
        meadowCreator.add(groundType: .grass, on: [(0,0), (0,1)])
        battleMeadow = meadowCreator.getBattleMeadow()
    }
    
    func setupBattleValues() {
        battleValues.set(.coins, to: 1000)
        battleValues.set(.points, to: 0)
        battleValues.set(.lives, to: 100)
    }
    
    func calculateEnemies() {
        for enemiesWave in enemiesWaves {
            for wave in enemiesWave.oneEnemiesTypeWaves {
                countOfEnemies += wave.enemies.count
            }
        }
    }
    
    func createWave() {
        //wave 0
        wavesCreator.createWave(startFrame: 0)
        wavesCreator.addOneRaceWave(id: 0, race: .goblin, level: .firstLevel, count: 2, interval: 40, startFrame: 10)
        wavesCreator.addOneRaceWave(id: 0, race: .troll, level: .firstLevel, count: 2, interval: 90, startFrame: 100)

        //wave 1
        wavesCreator.createWave(startFrame: 10)
        wavesCreator.addOneRaceWave(id: 1, race: .troll, level: .secondLevel, count: 3, interval: 100, startFrame: 10)
        wavesCreator.addOneRaceWave(id: 1, race: .orc, level: .secondLevel, count: 3, interval: 60, startFrame: 60)
        
        //wave 2
        wavesCreator.createWave(startFrame: 20)
        wavesCreator.addOneRaceWave(id: 2, race: .orc, level: .thirdLevel, count: 1, interval: 100, startFrame: 10)
        wavesCreator.addOneRaceWave(id: 2, race: .troll, level: .thirdLevel, count: 2, interval: 60, startFrame: 60)
        wavesCreator.addOneRaceWave(id: 2, race: .goblin, level: .firstLevel, count: 5, interval: 20, startFrame: 60)
        
        //wave 3
        wavesCreator.createWave(startFrame: 27)
        wavesCreator.addOneRaceWave(id: 3, race: .orc, level: .thirdLevel, count: 3, interval: 100, startFrame: 10)
        wavesCreator.addOneRaceWave(id: 3, race: .troll, level: .thirdLevel, count: 4, interval: 60, startFrame: 60)
        wavesCreator.addOneRaceWave(id: 3, race: .goblin, level: .firstLevel, count: 7, interval: 20, startFrame: 60)
        
        // set delegates for waves
        
        enemiesWaves = wavesCreator.enemiesWaves
    }
    
    
}



