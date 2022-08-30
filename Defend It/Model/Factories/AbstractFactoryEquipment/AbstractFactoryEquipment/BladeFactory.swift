//
//  BladeFactory.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.08.22.
//

import Foundation

struct BladeFactory: AbstractFactoryEquipment {
    
    static let defaultFactory = BladeFactory()
    
    func createFirstLevelEquipment() -> Equipment {
        BladeFirstLevel()
    }
    
    func createSecondLevelEquipment() -> Equipment {
        BladeSecondLevel()
    }
    
    func createThirdLevelEquipment() -> Equipment {
        BladeThirdLevel()
    }
    
    func createFourthLevelEquipment() -> Equipment {
        BladeFourthLevel()
    }
}
