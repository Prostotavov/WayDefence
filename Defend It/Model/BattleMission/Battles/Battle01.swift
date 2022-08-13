//
//  Battle01.swift
//  Defend It
//
//  Created by Роман Сенкевич on 6.07.22.
//

import SceneKit

final class Battle01: BattleMission {
    
    var id: Int = 1
    
    var battleFieldSize: Int = 7
    var countOfEnemies: Int = 0
    
    var battleMeadow: BattleMeadow
    var battleEnemyWaves: [EnemyWaveInput] = []
    var battleValues: BattleMissionValues!
    
    var meadowCreator: BattleMeadowCreator

    
    init() {
        
        meadowCreator = BattleMeadowCreatorImpl(size: battleFieldSize)
        
        battleMeadow = BattleMeadowImpl(size: battleFieldSize)
        createMeadow()
        
        EnemyPathManager.shared.battleFieldSize = battleFieldSize
        EnemyPathManager.shared.createBattleFieldGraph(size: battleFieldSize)
        EnemyPathManager.shared.setStart(coordinate: (3, 0))
        EnemyPathManager.shared.setTarget(coordinate: (3, 6))
        
        battleEnemyWaves = BattleMissionsEnemyData.shared.getEnemiesForBattle01()
        setupBattleValues()
        calculateEnemies()
    }
    
    func createMeadow() {
        meadowCreator.add(groundType: .grass, on: [(0,0), (0,1)])
        battleMeadow = meadowCreator.getBattleMeadow()
    }
    
    func setupBattleValues() {
        battleValues = BattleMissionsValuesData.shared.getValuesForBattle01()
    }
    
    func calculateEnemies() {
        for enemyWave in battleEnemyWaves {
            for oneRaceWave in enemyWave.oneRaceWaves {
                countOfEnemies += oneRaceWave.enemies.count
            }
        }
    }
}
