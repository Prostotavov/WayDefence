//
//  BuildingBattleInfo.swift
//  Defend It
//
//  Created by Роман Сенкевич on 13.09.22.
//

struct BuildingBattleInfo {

    var counter: Int = 0
    @Weak var enemiesInRadius: [AnyEnemy]
    
    internal init(counter: Int = 0) {
        self.counter = counter
    }
    
    internal init() {
        self.counter = 0
    }
}
