//
//  BattleMissionsEnemiesData.swift
//  Defend It
//
//  Created by Роман Сенкевич on 12.08.22.
//

import Foundation

struct BattleMissionsEnemyData {
    
    static var shared = BattleMissionsEnemyData()
    
    mutating func getEnemiesForBattle(id: BattleMissions) -> [EnemyWaveInput] {
        switch id {
        case .first:
            return getEnemiesForBattle01()
        case .second:
            return getEnemiesForBattle02()
        case .third:
            return getEnemiesForBattle03()
        case .four:
            return getEnemiesForBattle04()
        case .five:
            return getEnemiesForBattle05()
        }
    }
}

private extension BattleMissionsEnemyData {
    //MARK: -1-
    mutating func getEnemiesForBattle01() -> [EnemyWaveInput] {
        let creator = EnemyCreationManager()
        // wave 1
        creator.addWave(startFrame: 10)
        creator.addOneRaceWave(.goblin, .firstLevel, count: 3, interval: 60, startFrame: 10)
        creator.addOneRaceWave(.orc, .secondLevel, count: 3, interval: 60, startFrame: 210)
        creator.addOneRaceWave(.goblin, .secondLevel, count: 3, interval: 60, startFrame: 430)
        return creator.getWaves()
    }
    
    //MARK: -2-
    mutating func getEnemiesForBattle02() -> [EnemyWaveInput] {
        let creator = EnemyCreationManager()
        // wave 1
        creator.addWave(startFrame: 0)
        creator.addOneRaceWave(.orc, .secondLevel, count: 2, interval: 60, startFrame: 10)
        creator.addOneRaceWave(.goblin, .secondLevel, count: 2, interval: 100, startFrame: 230)
        
        // wave 2
        creator.addWave(startFrame: 300)
        creator.addOneRaceWave(.troll, .thirdLevel, count: 3, interval: 100, startFrame: 10)
        creator.addOneRaceWave(.goblin, .secondLevel, count: 3, interval: 70, startFrame: 120)
        
        return creator.getWaves()
    }
    
    //MARK: -3-
    mutating func getEnemiesForBattle03() -> [EnemyWaveInput] {
        let creator = EnemyCreationManager()
        // wave 1
        creator.addWave(startFrame: 0)
        creator.addOneRaceWave(.orc, .secondLevel, count: 2, interval: 60, startFrame: 10)
        creator.addOneRaceWave(.goblin, .secondLevel, count: 2, interval: 100, startFrame: 230)
        
        // wave 2
        creator.addWave(startFrame: 300)
        creator.addOneRaceWave(.orc, .thirdLevel, count: 5, interval: 100, startFrame: 10)
        
        return creator.getWaves()
    }
    
    //MARK: -4-
    mutating func getEnemiesForBattle04() -> [EnemyWaveInput] {
        let creator = EnemyCreationManager()
        // wave 1
        creator.addWave(startFrame: 0)
        creator.addOneRaceWave(.orc, .firstLevel, count: 5, interval: 60, startFrame: 10)
        creator.addOneRaceWave(.troll, .secondLevel, count: 6, interval: 100, startFrame: 430)
        
        return creator.getWaves()
    }
    
    //MARK: -5-
    mutating func getEnemiesForBattle05() -> [EnemyWaveInput] {
        let creator = EnemyCreationManager()
        // wave 1
        creator.addWave(startFrame: 0)
        creator.addOneRaceWave(.orc, .thirdLevel, count: 10, interval: 80, startFrame: 10)
        
        return creator.getWaves()
    }
}
