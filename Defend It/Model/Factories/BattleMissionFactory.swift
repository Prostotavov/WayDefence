//
//  BattleMissionFactory.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.07.22.
//

import SceneKit

protocol FactoryBattleMissionDelegate: AnyObject {
    func enemyReachedCastle()
    func addNodeToScene(_ node: SCNNode)
}

class FactoryBattleMission: EnemiesWaveDelegate, OneEnemiesTypeWaveDelegate {
    
    weak var delegate: FactoryBattleMissionDelegate!
        
    func createBattleMission(id: BattleMissions) -> BattleMission {
        switch id {
        case .first: return Battle01()
        case .second: return Battle02()
        case .third: return Battle03()
        case .four: return Battle04()
        case .five: return Battle05()
        }
    }
    
    func enemyReachedCastle() {
        delegate.enemyReachedCastle()
    }
    
    func addNodeToScene(_ node: SCNNode) {
        delegate.addNodeToScene(node)
    }
}
