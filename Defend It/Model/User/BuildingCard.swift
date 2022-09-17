//
//  BuildingCard.swift
//  Defend It
//
//  Created by Роман Сенкевич on 13.09.22.
//

import Foundation

struct BuildingCard {

    var info: BuildingInfo
    var parameter: BuildingParameter
    var appearance: BuildingAppearance
    
    internal init(building: AnyBuilding) {
        self.info = building.info
        self.parameter = building.parameter
        self.appearance = building.appearance
    }
    
    internal init(info: BuildingInfo, parameter: BuildingParameter, appearance: BuildingAppearance) {
        self.info = info
        self.parameter = parameter
        self.appearance = appearance
    }
    
    internal init() {
        self.info = BuildingInfo()
        self.parameter = BuildingParameter()
        self.appearance = BuildingAppearance()
    }
}
