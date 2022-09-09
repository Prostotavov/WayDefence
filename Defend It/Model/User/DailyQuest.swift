//
//  DailyQuest.swift
//  Defend It
//
//  Created by Роман Сенкевич on 8.09.22.
//

import Foundation

protocol DailyQuests {
    
    var tasks: [Task] {get set}
    func complete(type: TaskTypes, count: Int, object: TaskObjects, attribute: TaskObjectsAttributes?)
    func addTask(_ task: Task)
    func removeTask(_ taskToRemove: Task)
}

class DailyQuestsImp: DailyQuests {
    
    var tasks: [Task] = []
    
    init() {
        resetQuests()
    }
    
    func addTask(_ task: Task) {
        tasks.append(task)
    }
    
    func removeTask(_ taskToRemove: Task) {
        for (index, task) in tasks.enumerated() {
            if task.description == taskToRemove.description {
                tasks.remove(at: index)
                return
            }
        }
    }
    
    func complete(type: TaskTypes, count: Int, object: TaskObjects, attribute: TaskObjectsAttributes? = nil) {
        for (index, task) in tasks.enumerated() {
            if task.type != type {continue}
            if task.object != object {continue}
            if task.attribute == nil {
                tasks[index].increaseProgress(by: count)
                continue
            }
            if task.attribute != attribute {continue}
            tasks[index].increaseProgress(by: count)
        }
    }
}

extension DailyQuestsImp {
    
    private func resetQuests() {
        
        // MARK: -1-
        /// reward
        let valueReward_01 = EconomicAccountValuesImp(coins: 11, points: 0, gems: 0)
        let blade_01 = AbstractFactoryEquipmentImp.defaultFactory.create(.hammer, with: .firstLevel)
        let itemsReward_01: [(item: Equipment, quantity: Int)] = [(item: blade_01, quantity: 3)]
        let reward_01 = BattleRewardImp(economicAccountVlues: valueReward_01, equipments: itemsReward_01)
        
        /// init
        let title_01 = "receive one blade"
        let task01 = TaskImp(title: title_01, reward: reward_01, type: .receive, count: 1, object: .equipmentTypes(.blade))
        addTask(task01)
        
        // MARK: -2-
        /// reward
        let valueReward_02 = EconomicAccountValuesImp(coins: 33, points: 0, gems: 0)
        let arch_02 = AbstractFactoryEquipmentImp.defaultFactory.create(.blade, with: .firstLevel)
        let itemsReward_02: [(item: Equipment, quantity: Int)] = [(item: arch_02, quantity: 5)]
        let reward_02 = BattleRewardImp(economicAccountVlues: valueReward_02, equipments: itemsReward_02)
        
        /// init
        let title_02 = "receive two arch"
        let task02 = TaskImp(title: title_02, reward: reward_02, type: .receive, count: 2, object: .equipmentTypes(.arch))
        addTask(task02)
        
        // MARK: -3-
        /// reward
        let valueReward_03 = EconomicAccountValuesImp(coins: 67, points: 0, gems: 0)
        let arch_03 = AbstractFactoryEquipmentImp.defaultFactory.create(.hammer, with: .firstLevel)
        let itemsReward_03: [(item: Equipment, quantity: Int)] = [(item: arch_03, quantity: 12)]
        let reward_03 = BattleRewardImp(economicAccountVlues: valueReward_03, equipments: itemsReward_03)
        
        /// init
        let title_03 = "receive three shield"
        let task03 = TaskImp(title: title_03, reward: reward_03, type: .receive, count: 3, object: .equipmentTypes(.shield))
        addTask(task03)
    }
}
