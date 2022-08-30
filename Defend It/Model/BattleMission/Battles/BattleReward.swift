//
//  BattleReward.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.08.22.
//

import Foundation

protocol BattleReward {
    var economicAccountVlues: EconomicAccountValues {get set}
    var equipments: [(item: Equipment, quantity: Int)] {get set}
}

struct BattleRewardImp: BattleReward {
    var economicAccountVlues: EconomicAccountValues
    var equipments: [(item: Equipment, quantity: Int)]
}
