//
//  BattleMission.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.07.22.
//

import SceneKit

protocol BattleMission {
    var id: Int {get}
    var enemiesWaves: [EnemiesWave] {get set}
}



class BattleMissionImpl {
    
    var id: Int = 0
    
    var battleMeadow: [[GroundSquareImpl]] = []
    var enemiesWaves: [EnemiesWave] = []
    var battleValues: BattleValues!
    
    
    func setId(id: Int) {
        self.id = id
    }
}






