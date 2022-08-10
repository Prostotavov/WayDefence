//
//  EnemiesManager.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import SceneKit

enum EnemiesStates {
    case active
    case inactive
}

protocol EnemiesManager {
    
    func removeEnemy(_ enemy: AnyEnemy)
    func prohibitWalking(On coordination: (Int, Int))
    func allowWalking(On coordination: (Int, Int))
    func updateCounter()
    func getEnemyBy(_ enemyNode: SCNNode) -> AnyEnemy?
    func removeEnemies()
    func stopAllEnemies()
    func runAllEnemies()
    func enemyWounded(enemy: AnyEnemy)
    
    
}

protocol EnemiesManagerDelegate: AnyObject {
    func enemyReachedCastle()
    func addNodeToScene(_ node: SCNNode)
    func getBattleCounter() -> Int
}

class EnemiesManagerImpl: EnemiesManager, EnemiesWaveDelegate {
    
    var enemiesState: EnemiesStates!
    
    weak var delegate: EnemiesManagerDelegate!

    var enemiesWaves: [EnemiesWave]!
    
    var wavesCounter: Int = 0
    

}

extension EnemiesManagerImpl {
    
    func setupDelegates() {
        for wave in enemiesWaves {
            wave.setupDelegate(delegate: self)
        }
    }
    
    func enemyReachedCastle() {
        delegate.enemyReachedCastle()
    }
    
    func addNodeToScene(_ node: SCNNode) {
        delegate.addNodeToScene(node)
    }
    
    func removeEnemy(_ enemy: AnyEnemy) {
        for wave in enemiesWaves {
            if wave.startFrame > wavesCounter {continue}
            wave.removeEnemy(enemy)
        }
    }
    
    func removeEnemies() {
        for wave in enemiesWaves {
            if wave.startFrame > wavesCounter {continue}
            wave.removeEnemies()
        }
    }
}

extension EnemiesManagerImpl {
    func prohibitWalking(On coordination: (Int, Int)) {
        EnemyPathManager.shared.prohibitWalking(On: coordination)
        sendEnemyMovementManager(command: .runByNewPath)
    }
    
    func allowWalking(On coordination: (Int, Int)) {
        EnemyPathManager.shared.allowWalking(On: coordination)
        sendEnemyMovementManager(command: .runByNewPath)
    }
    
    func updateCounter() {
        wavesCounter += 1
        for wave in enemiesWaves {
            if wave.startFrame > wavesCounter {continue}
            if wave.startFrame == wavesCounter {
                wave.sendEnemyMovementManager(command: .runAllEnemies)
            }
            wave.updateCounter()
        }
    }
    
    func getEnemyBy(_ enemyNode: SCNNode) -> AnyEnemy? {
        for wave in enemiesWaves {
            if wave.startFrame > wavesCounter {continue} ///  not a prerequisite. if it causes an error in the future, you can delete it
            if let enemy = wave.getEnemyBy(enemyNode) {
                return enemy
            }
        }
        return nil
    }
    
    func enemyWounded(enemy: AnyEnemy) {
        for wave in enemiesWaves {
            if wave.startFrame > wavesCounter {continue} ///  not a prerequisite. if it causes an error in the future, you can delete it
            wave.enemyWounded(enemy: enemy)
        }
    }
    
    func stopAllEnemies() {
        sendEnemyMovementManager(command: .stopAllEnemies)
    }
    
    func runAllEnemies() {
        sendEnemyMovementManager(command: .runAllEnemies)
    }
    
    func sendEnemyMovementManager(command: EnemyMovementManagerCommands) {
        for wave in enemiesWaves {
            if wave.startFrame > wavesCounter {continue}
            wave.sendEnemyMovementManager(command: command)
        }
    }
    
}
