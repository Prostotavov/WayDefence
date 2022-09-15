//
//  BallistaFL.swift
//  Defend It
//
//  Created by MacBook Pro on 4.04.22.
//

import SceneKit

class BallistaFL: Building {
    
    var id: UUID
    var info: BuildingInfo
    var parameter: BuildingParameter
    var battleInfo: BuildingBattleInfo
    
    required init(_ buildingNode: SCNNode) {
        id = UUID()
        info = BuildingInfo(type: .ballista, level: .firstLevel,
                            upgrades: [.ballistaSL], upgradeSelection: [.ballistaSelectIcon],
                            buildingNode: buildingNode)
        parameter = BuildingParameter(radius: 3, damage: 40, attackSpeed: 0.3, buildingCost: 130, saleCost: 7)
        battleInfo = BuildingBattleInfo()
    }
}
