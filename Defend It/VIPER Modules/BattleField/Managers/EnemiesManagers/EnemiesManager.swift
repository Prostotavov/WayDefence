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
    func addEnemiesToScene()
}

protocol EnemiesManagerDelegate: AnyObject {
    func enemyReachedCastle()
    func addNodeToScene(_ node: SCNNode)
    func getBattleCounter() -> Int
}

class EnemiesManagerImpl: EnemiesManager, EnemiesWaveDelegate, BatttleMissionDelegate {
    
    
    var battleFieldSize: Int!
    var enemiesState: EnemiesStates!
    
    weak var delegate: EnemiesManagerDelegate!

    
    let battleMision = Battle01()
    var wavesCounter: Int = 0

    init(_ battleFieldSize: Int) {
        self.battleFieldSize = battleFieldSize
        battleMision.delegate = self
    }
}

extension EnemiesManagerImpl {
    func enemyReachedCastle() {
        delegate.enemyReachedCastle()
    }
    
    func addNodeToScene(_ node: SCNNode) {
        delegate.addNodeToScene(node)
    }
    
    func removeEnemy(_ enemy: AnyEnemy) {
        for wave in battleMision.enemiesWaves {
            if wave.startFrame > wavesCounter {continue}
            wave.removeEnemy(enemy)
        }
    }
    
    func removeEnemies() {
        for wave in battleMision.enemiesWaves {
            if wave.startFrame > wavesCounter {continue}
            wave.removeEnemies()
        }
    }
    
    func addEnemiesToScene() {
        for wave in battleMision.enemiesWaves {
            if wave.startFrame > wavesCounter {continue}
            wave.addEnemiesToScene()
        }
    }
}

extension EnemiesManagerImpl {
    func prohibitWalking(On coordination: (Int, Int)) {
        for wave in battleMision.enemiesWaves {
            wave.prohibitWalking(On: coordination)
        }
    }
    
    func allowWalking(On coordination: (Int, Int)) {
        for wave in battleMision.enemiesWaves {
            wave.allowWalking(On: coordination)
        }
    }
    
    func updateCounter() {
        wavesCounter += 1
        for wave in battleMision.enemiesWaves {
            if wave.startFrame > wavesCounter {continue}
            if wave.startFrame == wavesCounter {
                wave.runAllEnemies()
            }
            wave.updateCounter()
        }
    }
    
    func getEnemyBy(_ enemyNode: SCNNode) -> AnyEnemy? {
        for wave in battleMision.enemiesWaves {
            if wave.startFrame > wavesCounter {continue}
            if let enemy = wave.getEnemyBy(enemyNode) {
                return enemy
            }
        }
        return nil
    }
    
    func stopAllEnemies() {
        for wave in battleMision.enemiesWaves {
            if wave.startFrame > wavesCounter {continue}
            wave.stopAllEnemies()
        }
    }
    
    func runAllEnemies() {
        for wave in battleMision.enemiesWaves {
            if wave.startFrame > wavesCounter {continue}
            wave.runAllEnemies()
        }
    }
}
