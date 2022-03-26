//
//  AbstractFactoryEnemies.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import Foundation

enum EnemyRaces {
    case orc
    case goblin
    case troll
}

enum EnemyLevels: String {
    case firstLevel
    case secondLevel
    case thirdLevel
}

protocol AbstractFactoryEnemies {
    
    func createFirstLevelEnemy() -> EnemyTest
    func createSecondLevelEnemy() -> EnemyTest
    func createThirdLevelEnemy() -> EnemyTest
}
