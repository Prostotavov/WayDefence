//
//  Battle01.swift
//  Defend It
//
//  Created by Роман Сенкевич on 6.07.22.
//

import SceneKit

protocol BattleMission {
    var enemiesWaves: [EnemiesWave] {get set}
}

protocol BatttleMissionDelegate: AnyObject {
    func enemyReachedCastle()
    func addNodeToScene(_ node: SCNNode)
}

class Battle01: BattleMission, EnemiesWaveDelegate, OneEnemiesTypeWaveDelegate {

    
    var enemiesWaves: [EnemiesWave] = []
    
    weak var delegate: BatttleMissionDelegate!
    
    init() {
        createEnemiesWaves()
    }
    
    func createEnemiesWaves() {
        //wave 1
        let enemyWave01 = EnemiesWaveImpl(startFrame: 0)
        enemyWave01.delegate = self
        // oneRaceWaves
        let oneRaceWave01 = OneEnemiesTypeWaveImpl(7, race: .goblin, level: .firstLevel, count: 1, interval: 40, startFrame: 10)
        oneRaceWave01.delegate = self
        enemyWave01.oneEnemiesTypeWaves.append(oneRaceWave01)
        let oneRaceWave02 = OneEnemiesTypeWaveImpl(7, race: .troll, level: .firstLevel, count: 1, interval: 90, startFrame: 100)
        oneRaceWave02.delegate = self
        enemyWave01.oneEnemiesTypeWaves.append(oneRaceWave02)
        
        enemiesWaves.append(enemyWave01)
        
        //wave 2
        let enemyWave02 = EnemiesWaveImpl(startFrame: 400)
        enemyWave02.delegate = self
        // oneRaceWaves
        let oneRaceWave21 = OneEnemiesTypeWaveImpl(7, race: .troll, level: .secondLevel, count: 3, interval: 100, startFrame: 10)
        oneRaceWave21.delegate = self
        enemyWave02.oneEnemiesTypeWaves.append(oneRaceWave21)
        let oneRaceWave22 = OneEnemiesTypeWaveImpl(7, race: .orc, level: .secondLevel, count: 3, interval: 60, startFrame: 60)
        oneRaceWave22.delegate = self
        enemyWave02.oneEnemiesTypeWaves.append(oneRaceWave22)
        
        enemiesWaves.append(enemyWave02)
    }
}

extension Battle01 {
    func enemyReachedCastle() {
        delegate.enemyReachedCastle()
    }
    
    func addNodeToScene(_ node: SCNNode) {
        delegate.addNodeToScene(node)
    }
}
