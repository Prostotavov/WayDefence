//
//  Building.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

protocol Building: Hashable {
    
    var id: UUID {get set}
    var info: BuildingInfo {get}
    var parameter: BuildingParameter {get}
    var appearance: BuildingAppearance {get set}
    var battleInfo: BuildingBattleInfo {get set}
    
    init(_ buildingNode: SCNNode)
}

class AnyBuilding: Building {
    
    var id: UUID
    var info: BuildingInfo
    var parameter: BuildingParameter
    var appearance: BuildingAppearance
    var battleInfo: BuildingBattleInfo
    
    init<T: Building>(_ object: T) {
        id = object.id
        info = object.info
        parameter = object.parameter
        appearance = object.appearance
        battleInfo = object.battleInfo
    }
    
    required init(_ buildingNode: SCNNode) {
        id = UUID()
        info = BuildingInfo()
        parameter = BuildingParameter()
        appearance = BuildingAppearance()
        battleInfo = BuildingBattleInfo()
    }
    
    static func == (lhs: AnyBuilding, rhs: AnyBuilding) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


