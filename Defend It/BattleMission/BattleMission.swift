//
//  BattleMission.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.07.22.
//

import SceneKit

protocol BattleMission {
    var id: Int {get}
    
    var battleFieldSize: Int {get}
    var enemiesWaves: [EnemiesWave] {get set}
    var battleMeadow: BattleMeadow {get}
}






