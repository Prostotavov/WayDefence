//
//  ShieldFactory.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.08.22.
//

import Foundation

struct ShieldFactory: AbstractFactoryEquipment {
    
    static let defaultFactory = ShieldFactory()
    
    func createFirstLevelEquipment() -> Equipment {
        ShieldFirstLevel()
    }
    
    func createSecondLevelEquipment() -> Equipment {
        ShieldSecondLevel()
    }
    
    func createThirdLevelEquipment() -> Equipment {
        ShieldThirdLevel()
    }
    
    func createFourthLevelEquipment() -> Equipment {
        ShieldFourthLevel()
    }
}
