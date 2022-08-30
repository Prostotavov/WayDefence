//
//  HammerFactory.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.08.22.
//

import Foundation

struct HammerFactory: AbstractFactoryEquipment {
    
    static let defaultFactory = HammerFactory()
    
    func createFirstLevelEquipment() -> Equipment {
        HammerFirstLevel()
    }
    
    func createSecondLevelEquipment() -> Equipment {
        HammerSecondLevel()
    }
    
    func createThirdLevelEquipment() -> Equipment {
        HammerThirdLevel()
    }
    
    func createFourthLevelEquipment() -> Equipment {
        HammerFourthLevel()
    }
}
