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
    
    func createFirstLevelEnemy() -> AnyEnemy
    func createSecondLevelEnemy() -> AnyEnemy
    func createThirdLevelEnemy() -> AnyEnemy
}

class AbstractFactoryEnemiesImpl {
    
    static let defaultFactory = AbstractFactoryEnemiesImpl()
    
    func create(_ race: EnemyRaces, with level: EnemyLevels) -> AnyEnemy {
        switch race {
        case .goblin:
            switch level {
            case .firstLevel:
                return GoblinFactory.defaultFactory.createFirstLevelEnemy()
            case .secondLevel:
                return GoblinFactory.defaultFactory.createSecondLevelEnemy()
            case .thirdLevel:
                return GoblinFactory.defaultFactory.createThirdLevelEnemy()
            }
            
        case .orc:
            switch level {
            case .firstLevel:
                return OrcFactory.defaultFactory.createFirstLevelEnemy()
            case .secondLevel:
                return OrcFactory.defaultFactory.createSecondLevelEnemy()
            case .thirdLevel:
                return OrcFactory.defaultFactory.createThirdLevelEnemy()
            }
            
        case .troll:
            switch level {
            case .firstLevel:
                return TrollFactory.defaultFactory.createFirstLevelEnemy()
            case .secondLevel:
                return TrollFactory.defaultFactory.createSecondLevelEnemy()
            case .thirdLevel:
                return TrollFactory.defaultFactory.createThirdLevelEnemy()
            }
        }
    }
}
