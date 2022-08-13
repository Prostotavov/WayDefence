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
    
    mutating func getMeadowForBattle01() -> BattleMeadow {
        meadowCreator = BattleMeadowCreatorImpl(size: 10)
        meadowCreator.add(groundType: .water, on: [(0, 1), (3, 4)])
        meadowCreator.add(groundType: .lava, on: [(4, 2), (5, 4)])
        meadowCreator.add(groundType: .swamp, on: [(3, 1), (2, 2)])
        return meadowCreator.getBattleMeadow()
    }
    
    mutating func getMeadowForBattle02() -> BattleMeadow {
        meadowCreator = BattleMeadowCreatorImpl(size: 9)
        meadowCreator.add(groundType: .water, on: [(0, 1), (3, 4)])
        meadowCreator.add(groundType: .lava, on: [(4, 2), (5, 4)])
        meadowCreator.add(groundType: .swamp, on: [(3, 1), (2, 2)])
        return meadowCreator.getBattleMeadow()
    }
    
    mutating func getMeadowForBattle03() -> BattleMeadow {
        meadowCreator = BattleMeadowCreatorImpl(size: 8)
        meadowCreator.add(groundType: .water, on: [(0, 1), (3, 4)])
        meadowCreator.add(groundType: .lava, on: [(4, 2), (5, 4)])
        meadowCreator.add(groundType: .swamp, on: [(3, 1), (2, 2)])
        return meadowCreator.getBattleMeadow()
    }
    
    mutating func getMeadowForBattle04() -> BattleMeadow {
        meadowCreator = BattleMeadowCreatorImpl(size: 7)
        meadowCreator.add(groundType: .water, on: [(0, 1), (3, 4)])
        meadowCreator.add(groundType: .lava, on: [(4, 2), (5, 4)])
        meadowCreator.add(groundType: .swamp, on: [(3, 1), (2, 2)])
        return meadowCreator.getBattleMeadow()
    }
    
    mutating func getMeadowForBattle05() -> BattleMeadow {
        meadowCreator = BattleMeadowCreatorImpl(size: 12)
        meadowCreator.add(groundType: .water, on: [(0, 1), (3, 4)])
        meadowCreator.add(groundType: .lava, on: [(4, 2), (5, 4)])
        meadowCreator.add(groundType: .swamp, on: [(3, 1), (2, 2)])
        return meadowCreator.getBattleMeadow()
    }
}
