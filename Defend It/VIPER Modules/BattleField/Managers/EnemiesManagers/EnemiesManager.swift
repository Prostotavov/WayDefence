//
//  EnemiesManager.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import SceneKit

protocol EnemiesManager {
    var enemy: Enemy {get set}
    func run()
    func prohibitWalking(On coordination: (Int, Int))
    func allowWalking(On coordination: (Int, Int))
    func stopEnemyAndRunNewPath()
}

class EnemiesManagerImpl: EnemiesManager {
    var battleFieldSize: Int!
    var graph: BattleFieldGraph!
    var enemy: Enemy = EnemyImpl()
    var enemyPositionManager: EnemyPositionManager!
    
    init(_ battleFieldSize: Int) {
        self.battleFieldSize = battleFieldSize
        enemyPositionManager = EnemyPositionManagerImpl(battleFieldSize)
        enemy.enemyNode.position = enemyPositionManager.calculateStartPosition()
    }
    
    func run() {
        enemy.run(by: calculatePath())
    }
    
    func prohibitWalking(On coordination: (Int, Int)) {
        enemyPositionManager.prohibitWalking(On: coordination)
    }
    
    func allowWalking(On coordination: (Int, Int)) {
        enemyPositionManager.allowWalking(On: coordination)
    }
    
    func stopEnemyAndRunNewPath() {
        enemy.stopEnemyAndRunNewPath(by: calculatePath())
    }
    
    func calculatePath() -> [SCNVector3] {
        enemy.coordinate = Converter.toCoordinate(from: enemy.enemyNode.position)
        if enemy.coordinate.0 < 0 || enemy.coordinate.1 < 0 {
            enemy.coordinate = (3, 0)
        }
        return enemyPositionManager.calculatePath(for: enemy.coordinate)
    }
}
