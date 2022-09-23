//
//  BuildingBattleInfo.swift
//  Defend It
//
//  Created by Роман Сенкевич on 13.09.22.
//

struct BuildingBattleInfo {

    var counter: Int = 0
    var coordinate: (Int, Int)
    @Weak var enemiesInRadius: [AnyEnemy]
    
    internal init(counter: Int = 0, coordinate: (Int, Int) = (0, 0)) {
        self.counter = counter
        self.coordinate = coordinate
    }
    
    internal init() {
        self.counter = 0
        self.coordinate = (0, 0)
    }
}
