//
//  EquipmentBag.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.08.22.
//

import Foundation

protocol EquipmentBag {
    var bagItems: [(item: Equipment, quantity: Int)] {get}
    mutating func addItem(item: Equipment, in quantity: Int)
    mutating func addItems(items: [(item: Equipment, quantity: Int)])
    
    mutating func removeItem(item: Equipment, in quantity: Int)
}

struct EquipmentBagImp: EquipmentBag {
    
    var bagItems: [(item: Equipment, quantity: Int)] = []

    mutating func addItem(item: Equipment, in quantity: Int) {
        /// complete a task
        UserImp.shared.gameAccount?.dailyQuests?.complete(type: .receive, count: quantity, object: .equipmentTypes(item.type), attribute: .equipmentLevels(item.level))
        UserImp.shared.gameAccount?.achievements?.complete(type: .receive, count: quantity, object: .equipmentTypes(item.type), attribute: .equipmentLevels(item.level))
        /// complete a task -end-
        for (i, bagItem) in bagItems.enumerated() {
            if bagItem.item.name == item.name {
                bagItems[i].quantity += quantity
                return
            }
        }
        bagItems.append((item: item, quantity: quantity))
    }
    
    mutating func addItems(items: [(item: Equipment, quantity: Int)]) {
        for newItem in items {
            addItem(item: newItem.item, in: newItem.quantity)
        }
    }
    
    mutating func removeItem(item: Equipment, in quantity: Int) {
        /// complete a task -start-
        UserImp.shared.gameAccount?.dailyQuests?.complete(type: .spend, count: quantity, object: .equipmentTypes(item.type), attribute: .equipmentLevels(item.level))
        UserImp.shared.gameAccount?.achievements?.complete(type: .spend, count: quantity, object: .equipmentTypes(item.type), attribute: .equipmentLevels(item.level))
        /// complete a task -end-
        for (i, bagItem) in bagItems.enumerated() {
            if bagItem.item.name == item.name {
                if bagItems[i].quantity == quantity {
                    bagItems.remove(at: i)
                    return
                }
                bagItems[i].quantity -= quantity
            }
        }
    }
    
    mutating func removeItems(items: [(item: Equipment, quantity: Int)]) {
        for item in items {
            removeItem(item: item.item, in: item.quantity)
        }
    }
    
}
