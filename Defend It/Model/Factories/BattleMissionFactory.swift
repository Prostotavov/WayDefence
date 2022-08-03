//
//  BattleMissionFactory.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.07.22.
//

import SceneKit

enum BattleMissions: Int, CaseIterable {
    case first = 1
    case second = 2
    case third = 3
    case four = 4
}

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
        }
    }
    
    func enemyReachedCastle() {
        delegate.enemyReachedCastle()
    }
    
    func addNodeToScene(_ node: SCNNode) {
        delegate.addNodeToScene(node)
    }
}
