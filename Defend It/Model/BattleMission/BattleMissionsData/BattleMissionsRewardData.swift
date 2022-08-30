//
//  BattleMissionsRewardData.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.08.22.
//

import Foundation

struct BattleMissionsRewardData {
    
    static let shared = BattleMissionsRewardData()
    
    func getRewardForBattle(id: BattleMissions) -> BattleReward {
        switch id {
        case .first:
            return getRewardForBattle01()
        case .second:
            return getRewardForBattle02()
        case .third:
            return getRewardForBattle03()
        case .four:
            return getRewardForBattle04()
        case .five:
            return getRewardForBattle05()
        }
    }
}

private extension BattleMissionsRewardData {
    func getRewardForBattle01() -> BattleReward {
        let factory = AbstractFactoryEquipmentImp.defaultFactory
        return BattleRewardImp(
            economicAccountVlues: EconomicAccountValuesImp(coins: 100, points: 150, gems: 10),
            equipments: [
                (item: factory.create(.shield, with: .firstLevel), quantity: 1),
                (item: factory.create(.arch, with: .firstLevel), quantity: 2)
            ])
    }
    
    func getRewardForBattle02() -> BattleReward {
        let factory = AbstractFactoryEquipmentImp.defaultFactory
        return BattleRewardImp(
            economicAccountVlues: EconomicAccountValuesImp(coins: 250, points: 350, gems: 15),
            equipments: [
                (item: factory.create(.shield, with: .firstLevel), quantity: 1),
                (item: factory.create(.hammer, with: .firstLevel), quantity: 2)
            ])
    }
    
    func getRewardForBattle03() -> BattleReward {
        let factory = AbstractFactoryEquipmentImp.defaultFactory
        return BattleRewardImp(
            economicAccountVlues: EconomicAccountValuesImp(coins: 400, points: 650, gems: 25),
            equipments: [
                (item: factory.create(.shield, with: .firstLevel), quantity: 3),
                (item: factory.create(.arch, with: .firstLevel), quantity: 2),
                (item: factory.create(.blade, with: .firstLevel), quantity: 1)
            ])
    }
    
    func getRewardForBattle04() -> BattleReward {
        let factory = AbstractFactoryEquipmentImp.defaultFactory
        return BattleRewardImp(
            economicAccountVlues: EconomicAccountValuesImp(coins: 650, points: 950, gems: 35),
            equipments: [
                (item: factory.create(.shield, with: .firstLevel), quantity: 2),
                (item: factory.create(.blade, with: .firstLevel), quantity: 2)
            ])
    }
    
    func getRewardForBattle05() -> BattleReward {
        let factory = AbstractFactoryEquipmentImp.defaultFactory
        return BattleRewardImp(
            economicAccountVlues: EconomicAccountValuesImp(coins: 800, points: 1500, gems: 50),
            equipments: [
                (item: factory.create(.arch, with: .firstLevel), quantity: 4),
                (item: factory.create(.hammer, with: .firstLevel), quantity: 2),
                (item: factory.create(.blade, with: .firstLevel), quantity: 7)
            ])
    }
}
