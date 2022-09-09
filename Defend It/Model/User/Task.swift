//
//  Task.swift
//  Defend It
//
//  Created by Роман Сенкевич on 7.09.22.
//

import Foundation

enum TaskTypes: String {
    
    // building
    case build
    case sell
    case upgrade
    case repair
    
    // missions
    case complete
    
    // enemyies
    case kill
    
    // equipments
    case collect
    case receive
    case spend
}

enum TaskObjects: Equatable {
    
    /// build and sell
    case buildingTypes(BuildingTypes)
    
    /// kill
    case enemyRaces(EnemyRaces)
    
    /// get and spend
    case equipmentTypes(EquipmentTypes)
    
    var rawValue: String {
        switch self {
        case .buildingTypes(let type):
            return "\(type.rawValue)"
            
        case .enemyRaces(let race):
            return "\(race.rawValue)"
            
        case .equipmentTypes(let type):
            return "\(type.rawValue)"
        }
    }
}

enum TaskObjectsAttributes: Equatable {
    case enemyLevels(EnemyLevels)
    case buildingLevels(BuildingLevels)
    case equipmentLevels(EquipmentLevels)
    
    var rawValue: String {
        switch self {
        case .enemyLevels(let level):
            return "\(level.rawValue)"
            
        case .buildingLevels(let level):
            return "\(level.rawValue)"
            
        case .equipmentLevels(let level):
            return "\(level.rawValue)"
        }
    }
}


protocol Task {
    var title: String {get set}
    var reward: BattleReward {get set}
    var goalCount: Int {get set}
    var progressCount: Int {get set}
    var type: TaskTypes {get set}
    var object: TaskObjects {get set}
    var attribute: TaskObjectsAttributes? {get set}
    var isCompleted: Bool {get set}
    var isReceive: Bool {get set}
    var description: String {get}
    
    mutating func increaseProgress(by value: Int)
    mutating func receiveReward()
}

class TaskImp: Task {
    
    var title: String
    var reward: BattleReward
    var goalCount: Int
    var progressCount: Int
    var type: TaskTypes
    var object: TaskObjects
    var attribute: TaskObjectsAttributes?
    var isCompleted: Bool
    var isReceive: Bool
    
    var description: String {
        "\(type.rawValue) \(goalCount) \(object.rawValue) \(attribute?.rawValue ?? "without attributes")"
    }
    
    init(title: String, reward: BattleReward, type: TaskTypes, count: Int, object: TaskObjects, attribute: TaskObjectsAttributes? = nil) {
        self.title = title
        self.reward = reward
        self.goalCount =  count
        self.progressCount = 0
        self.type = type
        self.object = object
        self.attribute = attribute
        
        self.isCompleted = false
        self.isReceive = false
    }
    
    func increaseProgress(by value: Int) {
        progressCount += value
        if progressCount >= goalCount {
            progressCount = goalCount
            isCompleted = true
        }
    }
    
    func receiveReward() {
        self.isReceive = true
        
        let valueReward = reward.economicAccountVlues
        UserImp.shared.gameAccount?.gameAccountValues?.increase(.points, by: valueReward.get(.points))
        UserImp.shared.gameAccount?.gameAccountValues?.increase(.coins, by: valueReward.get(.coins))
        UserImp.shared.gameAccount?.gameAccountValues?.increase(.gems, by: valueReward.get(.gems))
        
        let itemsReward = reward.equipments
        UserImp.shared.gameAccount?.equipmentBag?.addItems(items: itemsReward)
    }
}
