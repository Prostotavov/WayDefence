//
//  BattleMissionFactory.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.07.22.
//

import SceneKit

enum battleIds: Int {
    case first = 1
    case second = 2
    case third = 3
    case four = 4
    case five = 5
    case six = 6
}

protocol FactoryBattleMissionDelegate: AnyObject {
    func enemyReachedCastle()
    func addNodeToScene(_ node: SCNNode)
}

class FactoryBattleMission: EnemiesWaveDelegate, OneEnemiesTypeWaveDelegate {
    
    weak var delegate: FactoryBattleMissionDelegate!
        
    func createBattleMission(id: Int) -> BattleMission {
        switch id {
        case 1: return Battle01()
        default: return Battle01()
        }
    }
    
    func enemyReachedCastle() {
        delegate.enemyReachedCastle()
    }
    
    func addNodeToScene(_ node: SCNNode) {
        delegate.addNodeToScene(node)
    }
}
