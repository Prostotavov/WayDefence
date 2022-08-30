//
//  ArchFactory.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.08.22.
//

import Foundation

struct ArchFactory: AbstractFactoryEquipment {
    
    static let defaultFactory = ArchFactory()
    
    func createFirstLevelEquipment() -> Equipment {
        ArchFirstLevel()
    }
    
    func createSecondLevelEquipment() -> Equipment {
        ArchSecondLevel()
    }
    
    func createThirdLevelEquipment() -> Equipment {
        ArchThirdLevel()
    }
    
    func createFourthLevelEquipment() -> Equipment {
        ArchFourthLevel()
    }
}
