//
//  EquipmentBag.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.08.22.
//

import Foundation

protocol EquipmentBag {
    var bagItems: [(item: Equipment, quantity: Int)] {get}
}

struct EquipmentBagImp: EquipmentBag {
    var bagItems: [(item: Equipment, quantity: Int)] = []
    
    mutating func addItem(item: Equipment, in quantity: Int) {
        bagItems.append((item: item, quantity: quantity))
    }
    
    mutating func removeItem(item: Equipment, in quantity: Int) {
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
    
}
