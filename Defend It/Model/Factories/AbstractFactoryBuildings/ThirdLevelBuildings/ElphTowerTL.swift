//
//  ElphTowerTL.swift
//  Defend It
//
//  Created by MacBook Pro on 4.04.22.
//

import SceneKit

class ElphTowerTL: Building {
    
    var id: UUID
    var info: BuildingInfo
    var parameter: BuildingParameter
    var appearance: BuildingAppearance
    var battleInfo: BuildingBattleInfo
    
    required init(_ buildingNode: SCNNode) {
        id = UUID()
        info = BuildingInfo(type: .elphTower, level: .thirdLevel, upgrades: [])
        parameter = BuildingParameter(radius: 3, damage: 40, attackSpeed: 0.3, buildingCost: 10, saleCost: 7)
        appearance = BuildingAppearance(icons: [.elphTowerSelectIcon], buildingNode: buildingNode, size: (3, 3))
        battleInfo = BuildingBattleInfo()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: ElphTowerTL, rhs: ElphTowerTL) -> Bool {
        lhs.id == rhs.id
    }
}
