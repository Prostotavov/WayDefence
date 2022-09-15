//
//  ElphTowerSL.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

class ElphTowerSL: Building {
    
    var id: UUID
    var info: BuildingInfo
    var parameter: BuildingParameter
    var battleInfo: BuildingBattleInfo
    
    required init(_ buildingNode: SCNNode) {
        id = UUID()
        info = BuildingInfo(type: .elphTower, level: .secondLevel,
                            upgrades: [.elphTowerTL], upgradeSelection: [.elphTowerSelectIcon],
                            buildingNode: buildingNode)
        parameter = BuildingParameter(radius: 3, damage: 40, attackSpeed: 0.3, buildingCost: 10, saleCost: 7)
        battleInfo = BuildingBattleInfo()
    }
}
