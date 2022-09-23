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
    var appearance: BuildingAppearance
    var battleInfo: BuildingBattleInfo
    
    required init(_ buildingNode: SCNNode) {
        id = UUID()
        info = BuildingInfo(type: .elphTower, level: .firstLevel, upgrades: [.elphTowerSL])
        parameter = BuildingParameter(radius: 2.5, damage: 25, attackSpeed: 0.3, buildingCost: 60, saleCost: 7)
        appearance = BuildingAppearance(icons: [.elphTowerSelectIcon], buildingNode: buildingNode, size: (3, 3))
        battleInfo = BuildingBattleInfo()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: ElphTowerFL, rhs: ElphTowerFL) -> Bool {
        lhs.id == rhs.id
    }
}
