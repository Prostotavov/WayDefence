//
//  BuildingParameter.swift
//  Defend It
//
//  Created by Роман Сенкевич on 13.09.22.
//

import UIKit

struct BuildingParameter {
    
    var radius: CGFloat
    var damage: CGFloat
    var attackSpeed: CGFloat
    var buildingCost: Int
    var saleCost: Int
    
    internal init(radius: CGFloat, damage: CGFloat, attackSpeed: CGFloat, buildingCost: Int, saleCost: Int) {
        self.radius = radius
        self.damage = damage
        self.attackSpeed = attackSpeed
        self.buildingCost = buildingCost
        self.saleCost = saleCost
    }
    
    internal init() {
        self.radius = 0
        self.damage = 0
        self.attackSpeed = 0
        self.buildingCost = 0
        self.saleCost = 0
    }
}
