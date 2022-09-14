//
//  ElphTowerFL.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

class ElphTowerFL: Building {
    
    var id: UUID
    var info: BuildingInfo
    var parameter: BuildingParameter
    var battleInfo: BuildingBattleInfo
    
    required init(_ buildingNode: SCNNode) {
        id = UUID()
        info = BuildingInfo(type: .elphTower, level: .firstLevel,
                            upgrades: [.elphTowerSL], upgradeSelection: [.elphTowerSelectIcon],
                            buildingNode: buildingNode)
        parameter = BuildingParameter(radius: 2.5, damage: 25, attackSpeed: 0.3, buildingCost: 60, saleCost: 7)
        battleInfo = BuildingBattleInfo()
    }
}
