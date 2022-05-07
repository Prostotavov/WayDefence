//
//  BuildingsManager.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import SceneKit

protocol BuildingsManagerDelegate: AnyObject {
    func remove(_ enemy: AnyEnemy)
}

protocol BuildingsManager {
    func showTowerSelectionPanel(On position: SCNVector3) -> SCNNode
    
    func create(_ buildingType: BuildingTypes, with level: BuildingLevels, and position: SCNVector3) -> Building
    func getUpgradeBuilding(for coordinate: (Int, Int)) -> Building
    
    func getBuildingName(with coordinate: (Int, Int)) -> String
    func getBuilding(with coordinate: (Int, Int)) -> Building
    func isExistBuiling(on coordinate: (Int, Int)) -> Bool
    
    func deleteBuilding(with coordinate: (Int, Int))
    
    func add(_ enemy: AnyEnemy, toBuildingWith coordinate: (Int, Int))
    func remove(_ enemy: AnyEnemy, fromBuildingWith coordinate: (Int, Int))
    
    func updateCounter()
}

class BuildingsManagerImpl: BuildingsManager {
    
    var towerBuilder = TowerBuilderImpl()
    var towerSelectionPanel: TowerSelectionPanel!
    var battleFieldSize: Int!
    var buildings: [[Building?]]!
    
    weak var delegate: BuildingsManagerDelegate!
    
    init(_ battleFieldSize: Int) {
        self.battleFieldSize = battleFieldSize
        createBuildingsArray()
        setupBuildingSelectionPanel()
    }
    
    private func createBuildingsArray() {
        let row: [Building?] = Array(repeating: nil, count: battleFieldSize)
        buildings = Array(repeating: row, count: battleFieldSize)
    }
    
    private func setupBuildingSelectionPanel() {
        towerSelectionPanel = TowerSelectionPanelImpl()
    }
    
    func showTowerSelectionPanel(On position: SCNVector3) -> SCNNode {
        let coordinate = Converter.toCoordinate(from: position)
        if isExistBuiling(on: coordinate) {
            return towerSelectionPanel.show(for: buildings[coordinate.0][coordinate.1]!)
        } else {
            return towerSelectionPanel.show(on: position)
        }
    }
    
    func create(_ buildingType: BuildingTypes, with level: BuildingLevels, and position: SCNVector3) -> Building {
        let coordinate = Converter.toCoordinate(from: position)
        let building = AbstactFactoryBuildingsImpl.defaultFactory.create(buildingType, with: level)
        building.buildingNode.position = position
        buildings[coordinate.0][coordinate.1] = building
        addPhysicsBody(for: building)
        return building
    }
    
    func getUpgradeBuilding(for coordinate: (Int, Int)) -> Building {
        let building = buildings[coordinate.0][coordinate.1]!
        let id = building.id
        let type = building.type
        let level = getNextLevel(after: building.level)
        let position = buildings[coordinate.0][coordinate.1]!.buildingNode.position
        var upgradeBuilding = AbstactFactoryBuildingsImpl.defaultFactory.create(type, with: level)
        let enemiesInRadius = building.enemiesInRadius
        
        upgradeBuilding.buildingNode.position = position
        upgradeBuilding.buildingNode.name = id.uuidString
        upgradeBuilding.enemiesInRadius = enemiesInRadius
        buildings[coordinate.0][coordinate.1] = upgradeBuilding
        addPhysicsBody(for: upgradeBuilding)
        return upgradeBuilding
    }
    
    private func getNextLevel(after level: BuildingLevels) -> BuildingLevels {
        switch level {
        case .firstLevel:
            return .secondLevel
        case .secondLevel:
            return .thirdLevel
        case .thirdLevel:
            return .thirdLevel
        }
    }
    
    func deleteBuilding(with coordinate: (Int, Int)) {
        buildings[coordinate.0][coordinate.1] = nil
    }
    
    func getBuildingName(with coordinate: (Int, Int)) -> String {
        buildings[coordinate.0][coordinate.1]!.buildingNode.name!
    }
    
    func getBuilding(with coordinate: (Int, Int)) -> Building {
        buildings[coordinate.0][coordinate.1]!
    }
    
    func isExistBuiling(on coordinate: (Int, Int)) -> Bool {
        buildings[coordinate.0][coordinate.1] != nil
    }
    
}

extension BuildingsManagerImpl {
    
    func addPhysicsBody(for building: Building) {
        let physicsShape = SCNPhysicsShape(geometry: SCNSphere(radius: building.radius / 3))
        let physicsBody = SCNPhysicsBody(type: .kinematic, shape: physicsShape)
        
        physicsBody.isAffectedByGravity = false
        physicsBody.categoryBitMask = 1
        physicsBody.contactTestBitMask = 2
        
        let physicsRadiusNode = SCNNode()
        physicsRadiusNode.name = NodeNames.physicsRadiusNode.rawValue
        physicsRadiusNode.physicsBody = physicsBody
        building.buildingNode.addChildNode(physicsRadiusNode)
    }
}


extension BuildingsManagerImpl {
    func add(_ enemy: AnyEnemy, toBuildingWith coordinate: (Int, Int)) {
        if buildings[coordinate.0][coordinate.1]?.level != .firstLevel {return}
        buildings[coordinate.0][coordinate.1]?.enemiesInRadius.append(enemy)
    }
    
    func remove(_ enemy: AnyEnemy, fromBuildingWith coordinate: (Int, Int)) {
        let remainingEnemies = buildings[coordinate.0][coordinate.1]!.enemiesInRadius.filter{$0.id != enemy.id}
        buildings[coordinate.0][coordinate.1]!.enemiesInRadius = remainingEnemies
    }
}

extension BuildingsManagerImpl {
    
    func updateCounter() {
        
        for (x, _) in buildings.enumerated() {
            for (z, _) in buildings[x].enumerated() {
                if buildings[x][z] == nil  { continue }
                if buildings[x][z]!.counter != 0 { buildings[x][z]?.counter -= 1; continue }
                if buildings[x][z]!.enemiesInRadius == [] { continue }
                buildings[x][z]!.counter = Converter.toCounter(from: buildings[x][z]!.attackSpeed)
                attackEnemy(by: buildings[x][z]!)
            }
        }
    }
    
    func attackEnemy(by building: Building) {
        let attackedEnemy = building.enemiesInRadius.first!
        attackedEnemy.healthPoints -= building.damage
        if attackedEnemy.healthPoints <= 0 {
            delegate.remove(attackedEnemy)
            print(building.enemiesInRadius.map{$0.race})
        }
    }
    
}
