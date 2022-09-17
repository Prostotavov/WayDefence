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
    var appearance: BuildingAppearance
    var battleInfo: BuildingBattleInfo
    
    required init(_ buildingNode: SCNNode) {
        id = UUID()
        info = BuildingInfo(type: .wall, level: .firstLevel, upgrades: [.wallSL])
        parameter = BuildingParameter(radius: 3, damage: 1, attackSpeed: 0.3, buildingCost: 35, saleCost: 7)
        appearance = BuildingAppearance(icons: [.wallSelectIcon], buildingNode: buildingNode, size: (3, 3))
        battleInfo = BuildingBattleInfo()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: WallFL, rhs: WallFL) -> Bool {
        lhs.id == rhs.id
    }
}
