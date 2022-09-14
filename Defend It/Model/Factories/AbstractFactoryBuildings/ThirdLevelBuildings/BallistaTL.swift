//
//  BallistaTL.swift
//  Defend It
//
//  Created by MacBook Pro on 4.04.22.
//

import SceneKit

class BallistaTL: Building {
    
    var id: UUID
    var info: BuildingInfo
    var parameter: BuildingParameter
    var battleInfo: BuildingBattleInfo
    
    required init(_ buildingNode: SCNNode) {
        id = UUID()
        info = BuildingInfo(type: .ballista, level: .thirdLevel,
                            upgrades: [], upgradeSelection: [.ballistaSelectIcon],
                            buildingNode: buildingNode)
        parameter = BuildingParameter(radius: 3, damage: 40, attackSpeed: 0.3, buildingCost: 10, saleCost: 7)
        battleInfo = BuildingBattleInfo()
    }
}
