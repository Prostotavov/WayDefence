//
//  Battle01.swift
//  Defend It
//
//  Created by Роман Сенкевич on 6.07.22.
//

import SceneKit

final class Battle01: BattleMission {
    var id: Int = 1
    
    var battleFieldWidth: Int = 7
    var bettleFieldHeight: Int = 7
    
    var enemiesWaves: [EnemiesWave] = []
    let wavesCreator = EnemyWavesCreatorImpl()
    let meadowCreator = BattleMeadowCreatorImpl()
    let battlevaluesCreator = BattleMeadowCreatorImpl()
    
    init() {
        createWave()
    }
    
    func createMeadow() {
        
    }
    
    func setupBattleValues() {
        
    }
    
    func createWave() {
        wavesCreator.createWave(startFrame: 0)
        wavesCreator.addOneRaceWave(id: 0, race: .goblin, level: .firstLevel, count: 2, interval: 40, startFrame: 10)
        wavesCreator.addOneRaceWave(id: 0, race: .troll, level: .firstLevel, count: 2, interval: 90, startFrame: 100)

        //wave 1
        wavesCreator.createWave(startFrame: 800)
        wavesCreator.addOneRaceWave(id: 1, race: .troll, level: .secondLevel, count: 3, interval: 100, startFrame: 10)
        wavesCreator.addOneRaceWave(id: 1, race: .orc, level: .secondLevel, count: 3, interval: 60, startFrame: 60)
        
        //wave 2
        wavesCreator.createWave(startFrame: 1600)
        wavesCreator.addOneRaceWave(id: 2, race: .orc, level: .thirdLevel, count: 1, interval: 100, startFrame: 10)
        wavesCreator.addOneRaceWave(id: 2, race: .troll, level: .thirdLevel, count: 2, interval: 60, startFrame: 60)
        wavesCreator.addOneRaceWave(id: 2, race: .goblin, level: .firstLevel, count: 5, interval: 20, startFrame: 60)
        
        // set delegates for waves
        wavesCreator.setupEnemiesWaves()
        
        enemiesWaves = wavesCreator.enemiesWaves
    }
}
