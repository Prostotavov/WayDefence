//
//  EnemiesManager.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import SceneKit

protocol EnemiesManager {
    
    var enemy: Enemy {get}
    func sendEnemy()
    func sendEnemyByNewPath()
    func prohibitWalking(On coordination: (Int, Int))
    func allowWalking(On coordination: (Int, Int))
}

class EnemiesManagerImpl: EnemiesManager {
    var battleFieldSize: Int!
    var enemy: Enemy = TrollFactory.defaultFactory.createSecondLevelEnemy()
    var enemyPositionManager: EnemyPositionManager!
    
    init(_ battleFieldSize: Int) {
        self.battleFieldSize = battleFieldSize
        enemyPositionManager = EnemyPositionManagerImpl(battleFieldSize)
        enemy.enemyNode.position = enemyPositionManager.culculateStartPosition()
    }

    
    func sendEnemy() {
        enemyPositionManager.run(enemy)
    }
    
    func sendEnemyByNewPath() {
        enemyPositionManager.runByNewPath(enemy)
    }
    
    func prohibitWalking(On coordination: (Int, Int)) {
        enemyPositionManager.prohibitWalking(On: coordination)
    }
    
    func allowWalking(On coordination: (Int, Int)) {
        enemyPositionManager.allowWalking(On: coordination)
    }
}
