//
//  AbstractFactoryEquipment.swift
//  Defend It
//
//  Created by Роман Сенкевич on 30.08.22.
//

import Foundation

protocol AbstractFactoryEquipment {
    
    func createFirstLevelEquipment() -> Equipment
    func createSecondLevelEquipment() -> Equipment
    func createThirdLevelEquipment() -> Equipment
    func createFourthLevelEquipment() -> Equipment
}

class AbstractFactoryEquipmentImp {
    
    static let defaultFactory = AbstractFactoryEquipmentImp()
    
    func create(_ type: EquipmentTypes, with level: EquipmentLevels) -> Equipment {
        switch type {
        case .arch:
            switch level {
            case .firstLevel:
                return ArchFactory.defaultFactory.createFirstLevelEquipment()
            case .secondLevel:
                return ArchFactory.defaultFactory.createSecondLevelEquipment()
            case .thirdLevel:
                return ArchFactory.defaultFactory.createThirdLevelEquipment()
            case .fourthLevel:
                return ArchFactory.defaultFactory.createFourthLevelEquipment()
            }
            
        case .hammer:
            switch level {
            case .firstLevel:
                return HammerFactory.defaultFactory.createFirstLevelEquipment()
            case .secondLevel:
                return HammerFactory.defaultFactory.createSecondLevelEquipment()
            case .thirdLevel:
                return HammerFactory.defaultFactory.createThirdLevelEquipment()
            case .fourthLevel:
                return HammerFactory.defaultFactory.createFourthLevelEquipment()
            }
            
        case .blade:
            switch level {
            case .firstLevel:
                return BladeFactory.defaultFactory.createFirstLevelEquipment()
            case .secondLevel:
                return BladeFactory.defaultFactory.createSecondLevelEquipment()
            case .thirdLevel:
                return BladeFactory.defaultFactory.createThirdLevelEquipment()
            case .fourthLevel:
                return BladeFactory.defaultFactory.createFourthLevelEquipment()
            }
            
        case .shield:
            switch level {
            case .firstLevel:
                return ShieldFactory.defaultFactory.createFirstLevelEquipment()
            case .secondLevel:
                return ShieldFactory.defaultFactory.createSecondLevelEquipment()
            case .thirdLevel:
                return ShieldFactory.defaultFactory.createThirdLevelEquipment()
            case .fourthLevel:
                return ShieldFactory.defaultFactory.createFourthLevelEquipment()
            }
            
        }
    }
}
