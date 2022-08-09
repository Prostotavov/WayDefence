//
//  BattleMission.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.07.22.
//

import SceneKit

protocol BattleMission {
    
    var countOfEnemies: Int {get set}
    var id: Int {get}
    
    var battleFieldSize: Int {get}
    var enemiesWaves: [EnemiesWave] {get set}
    var battleMeadow: BattleMeadow {get}
    var battleValues: BattleValues {get}
    
    var wavesCreator: EnemyWavesCreatorImpl {get set}
}





