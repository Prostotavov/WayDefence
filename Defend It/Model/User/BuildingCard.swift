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
    
    internal init(building: Building) {
        self.info = building.info
        self.parameter = building.parameter
    }
    
    internal init(info: BuildingInfo, parameter: BuildingParameter) {
        self.info = info
        self.parameter = parameter
    }
    
    internal init() {
        self.info = BuildingInfo()
        self.parameter = BuildingParameter()
    }
}
