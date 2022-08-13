//
//  Battle04.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.07.22.
//

import SceneKit

final class Battle04: BattleMission {
    var id: Int = 4
    
    var battleFieldSize: Int = 9
    var countOfEnemies: Int = 0
    
    var battleMeadow: BattleMeadow
    var battleEnemyWaves: [EnemyWaveInput] = []
    var battleValues: BattleMissionValues!
    
    
    var meadowCreator: BattleMeadowCreator
    
    init() {
        
        EnemyPathManager.shared.battleFieldSize = battleFieldSize
        EnemyPathManager.shared.createBattleFieldGraph(size: battleFieldSize)
        EnemyPathManager.shared.setStart(coordinate: (3, 0))
        EnemyPathManager.shared.setTarget(coordinate: (3, 6))
        battleEnemyWaves = BattleMissionsEnemyData.shared.getEnemiesForBattle04()
        
        
        
        meadowCreator = BattleMeadowCreatorImpl(size: battleFieldSize)
        
        battleMeadow = BattleMeadowImpl(size: battleFieldSize)
        createMeadow()

        setupBattleValues()
        calculateEnemies()
    }
    
    func createMeadow() {
        meadowCreator.add(groundType: .grass, on: [(0,0), (0,1)])
        battleMeadow = meadowCreator.getBattleMeadow()
    }
    
    func setupBattleValues() {
        battleValues = BattleMissionsValuesData.shared.getValuesForBattle04()
    }
    
    func calculateEnemies() {
        for enemyWave in battleEnemyWaves {
            for oneRaceWave in enemyWave.oneRaceWaves {
                countOfEnemies += oneRaceWave.enemies.count
            }
        }
    }
    
}


