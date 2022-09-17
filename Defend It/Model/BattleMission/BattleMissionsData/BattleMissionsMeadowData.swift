//
//  BattleMissionsMeadowData.swift
//  Defend It
//
//  Created by Роман Сенкевич on 13.08.22.
//

import Foundation

struct BattleMissionsMeadowData {
    
    var meadowCreator: BattleMeadowCreator!
    
    static var shared = BattleMissionsMeadowData()
    
    mutating func getMeadowForBattle(id: BattleMissions) -> BattleMeadow {
        switch id {
        case .first:
            return getMeadowForBattle01()
        case .second:
            return getMeadowForBattle02()
        case .third:
            return getMeadowForBattle03()
        case .four:
            return getMeadowForBattle04()
        case .five:
            return getMeadowForBattle05()
        }
    }
}

private extension BattleMissionsMeadowData {
    func setEnemyPathManager(size: Int, start: (Int, Int), target: (Int, Int)) {
        EnemyPathManager.shared.createBattleFieldGraph(size: size)
        EnemyPathManager.shared.setStart(coordinate: start)
        EnemyPathManager.shared.setTarget(coordinate: target)
    }
    
    mutating func getMeadowForBattle01() -> BattleMeadow {
        let size = 30
        let start: (Int, Int) = (5, 5)
        let target: (Int, Int) = (size - 1, size - 1)
        meadowCreator = BattleMeadowCreatorImpl(size: size)
        setEnemyPathManager(size: size, start: start, target: target)
        meadowCreator.add(groundType: .snow, on: [(5, 5)])
        meadowCreator.add(groundType: .water, on: [(0, 1), (3, 4)])
        meadowCreator.add(groundType: .lava, on: [(4, 2), (5, 4)])
        meadowCreator.add(groundType: .swamp, on: [(3, 1), (2, 2)])
        return meadowCreator.getBattleMeadow()
    }
    
    mutating func getMeadowForBattle02() -> BattleMeadow {
        let size = 27
        let start: (Int, Int) = (0, 0)
        let target: (Int, Int) = (size - 1, size - 1)
        meadowCreator = BattleMeadowCreatorImpl(size: size)
        setEnemyPathManager(size: size, start: start, target: target)
        meadowCreator.add(groundType: .water, on: [(0, 1), (3, 4)])
        meadowCreator.add(groundType: .lava, on: [(4, 2), (5, 4)])
        meadowCreator.add(groundType: .swamp, on: [(3, 1), (2, 2)])
        return meadowCreator.getBattleMeadow()
    }
    
    mutating func getMeadowForBattle03() -> BattleMeadow {
        let size = 24
        let start: (Int, Int) = (0, 0)
        let target: (Int, Int) = (size - 1, size - 1)
        meadowCreator = BattleMeadowCreatorImpl(size: size)
        setEnemyPathManager(size: size, start: start, target: target)
        meadowCreator.add(groundType: .water, on: [(0, 1), (3, 4)])
        meadowCreator.add(groundType: .lava, on: [(4, 2), (5, 4)])
        meadowCreator.add(groundType: .swamp, on: [(3, 1), (2, 2)])
        return meadowCreator.getBattleMeadow()
    }
    
    mutating func getMeadowForBattle04() -> BattleMeadow {
        let size = 21
        let start: (Int, Int) = (0, 0)
        let target: (Int, Int) = (size - 1, size - 1)
        meadowCreator = BattleMeadowCreatorImpl(size: size)
        setEnemyPathManager(size: size, start: start, target: target)
        meadowCreator.add(groundType: .water, on: [(0, 1), (3, 4)])
        meadowCreator.add(groundType: .lava, on: [(4, 2), (5, 4)])
        meadowCreator.add(groundType: .swamp, on: [(3, 1), (2, 2)])
        return meadowCreator.getBattleMeadow()
    }
    
    mutating func getMeadowForBattle05() -> BattleMeadow {
        let size = 36
        let start: (Int, Int) = (0, 0)
        let target: (Int, Int) = (size - 1, size - 1)
        meadowCreator = BattleMeadowCreatorImpl(size: size)
        setEnemyPathManager(size: size, start: start, target: target)
        meadowCreator.add(groundType: .water, on: [(0, 1), (3, 4)])
        meadowCreator.add(groundType: .lava, on: [(4, 2), (5, 4)])
        meadowCreator.add(groundType: .swamp, on: [(3, 1), (2, 2)])
        return meadowCreator.getBattleMeadow()
    }
}
