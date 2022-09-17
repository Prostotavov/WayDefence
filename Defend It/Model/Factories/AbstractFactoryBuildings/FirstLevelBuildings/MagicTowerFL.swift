//
//  MagicTowerFL.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

class MagicTowerFL: Building {
    
    var id: UUID
    var info: BuildingInfo
    var parameter: BuildingParameter
    var appearance: BuildingAppearance
    var battleInfo: BuildingBattleInfo
    
    required init(_ buildingNode: SCNNode) {
        id = UUID()
        info = BuildingInfo(type: .magicTower, level: .firstLevel, upgrades: [.magicTowerSL])
        parameter = BuildingParameter(radius: 3, damage: 40, attackSpeed: 0.3, buildingCost: 90, saleCost: 7)
        appearance = BuildingAppearance(icons: [.magicTowerSelectIcon], buildingNode: buildingNode, size: (3, 3))
        battleInfo = BuildingBattleInfo()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: MagicTowerFL, rhs: MagicTowerFL) -> Bool {
        lhs.id == rhs.id
    }
}








