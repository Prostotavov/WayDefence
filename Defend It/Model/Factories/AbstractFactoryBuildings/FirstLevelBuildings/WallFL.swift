//
//  WallFL.swift
//  Defend It
//
//  Created by MacBook Pro on 4.04.22.
//

import SceneKit

class WallFL: Building {
    
    var id: UUID
    var info: BuildingInfo
    var parameter: BuildingParameter
    var battleInfo: BuildingBattleInfo
    
    required init(_ buildingNode: SCNNode) {
        id = UUID()
        info = BuildingInfo(type: .wall, level: .firstLevel,
                            upgrades: [.wallSL], upgradeSelection: [.wallSelectIcon],
                            buildingNode: buildingNode)
        parameter = BuildingParameter(radius: 3, damage: 40, attackSpeed: 0.3, buildingCost: 35, saleCost: 7)
        battleInfo = BuildingBattleInfo()
    }
}
