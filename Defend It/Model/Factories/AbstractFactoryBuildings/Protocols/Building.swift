//
//  Building.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import SceneKit

protocol Building {
    
    var id: UUID {get set}
    var info: BuildingInfo {get}
    var parameter: BuildingParameter {get}
    var battleInfo: BuildingBattleInfo {get set}
    
    init(_ buildingNode: SCNNode)
}
