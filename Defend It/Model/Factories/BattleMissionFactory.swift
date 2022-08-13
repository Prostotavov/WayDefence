//
//  BattleMissionFactory.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.07.22.
//

import SceneKit



class FactoryBattleMission {
    
    func createBattleMission(id: BattleMissions) -> BattleMission {
        let meadow = BattleMissionsMeadowData.shared.getMeadowForBattle(id: id)
        let enemies = BattleMissionsEnemyData.shared.getEnemiesForBattle(id: id)
        let missionValues = BattleMissionsValuesData.shared.getMeadowForBattle(id: id)
        return BattleMissionImp(enemies: enemies, meadow: meadow, battleValues: missionValues)
    }
}
