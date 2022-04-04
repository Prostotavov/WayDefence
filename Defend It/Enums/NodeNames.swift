//
//  NodeNames.swift
//  Defend It
//
//  Created by MacBook Pro on 25.03.22.
//

import Foundation

enum NodeNames: String {
    case floor = "floor"
    case groundCell = "groundCellNode"
    case magicTower = "magicTowerBuildingNode"
    case elphTower = "elphTowerBuildingNode"
    case enemy = "enemyNode"
    case buildingSelectionPanel = "buildingSelectionPanelNode"
    
    // for enemies -start-
    case goblinFL = "goblinFLNode"
    case goblinSL = "goblinSLNode"
    case goblinTL = "goblinTLNode"
    
    case orcFL = "orcFLNode"
    case orcSL = "orcSLNode"
    case orcTL = "orcTLNode"
    
    case trollFL = "trollFLNode"
    case trollSL = "trollSLNode"
    case trollTL = "trollTLNode"
    // for enemies -end-
    
    // for buldings -start-
    
    case magicTowerFL = "magicTowerFLNode"
    case magicTowerSL = "magicTowerSLNode"
    case magicTowerTL = "magicTowerTLNode"
    
    case elphTowerFL = "elphTowerFLNode"
    case elphTowerSL = "elphTowerSLNode"
    case elphTowerTL = "elphTowerTLNode"
    
    case ballistaFL = "ballistaFLNode"
    case ballistaSL = "ballistaSLNode"
    case ballistaTL = "ballistaTLNode"
    
    case wallFL = "wallFLNode"
    case wallSL = "wallSLNode"
    case wallTL = "wallTLNode"
    // for buldings -end-
    

}
