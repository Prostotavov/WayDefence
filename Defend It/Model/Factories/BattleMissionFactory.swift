//
//  BattleMissionFactory.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.07.22.
//

import SceneKit



class FactoryBattleMission {
    
    func createBattleMission(id: BattleMissions) -> BattleMission {
        switch id {
        case .first: return Battle01()
        case .second: return Battle02()
        case .third: return Battle03()
        case .four: return Battle04()
        case .five: return Battle05()
        }
    }
}
