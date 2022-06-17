//
//  BuildingsManager.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import SceneKit

protocol BuildingsManagerDelegate: AnyObject {
    func enemyKilled(_ enemy: AnyEnemy)
}

protocol BuildingsManager {
    func getTowerSelectionPanel(On position: SCNVector3) -> SCNNode
    func isExistBuiling(on coordinate: (Int, Int)) -> Bool
    func deleteBuilding(with coordinate: (Int, Int))
    func add(_ enemy: AnyEnemy, toBuildingWith coordinate: (Int, Int))
    func remove(_ enemy: AnyEnemy, fromBuildingWith coordinate: (Int, Int))
    func updateCounter()
    
    func calculateCost(ofBuilding buildingType: BuildingTypes, by coordinate: (Int, Int)) -> Int
    func getBuilding(by coordinate: (Int, Int)) -> Building
    func build(_ buildingType: BuildingTypes, by coordinate: (Int, Int))
    func updateBuilding(by coordinate: (Int, Int))
    
    func stopAtack()
    func runAtack()
}

class BuildingsManagerImpl: BuildingsManager {
    
    var towerSelectionPanel: TowerSelectionPanel!
    var battleFieldSize: Int!
    var buildings: [[Building?]]!
    var isActive: Bool = false
    
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
    
    func getTowerSelectionPanel(On position: SCNVector3) -> SCNNode {
        let coordinate = Converter.toCoordinate(from: position)
        if isExistBuiling(on: coordinate) {
            return towerSelectionPanel.show(for: buildings[coordinate.0][coordinate.1]!)
        } else {
            return towerSelectionPanel.show(on: position)
        }
    }
    
    func build(_ buildingType: BuildingTypes, by coordinate: (Int, Int)) {
        let building = AbstactFactoryBuildingsImpl.defaultFactory.create(buildingType, with: .firstLevel)
        buildings[coordinate.0][coordinate.1] = building
        building.buildingNode.position = Converter.toPosition(from: coordinate)
        addPhysicsBody(for: building)
    }
    
    func updateBuilding(by coordinate: (Int, Int)) {
        let oldBuilding = getBuilding(by: coordinate)
        let type = oldBuilding.type
        let nextLevel = getNextLevel(after: oldBuilding.level)
        var newBuilding = AbstactFactoryBuildingsImpl.defaultFactory.create(type, with: nextLevel)
        copyJointDataFrom(oldBuilding, to: &newBuilding)
        oldBuilding.buildingNode.removeFromParentNode()
        buildings[coordinate.0][coordinate.1] = newBuilding
        addPhysicsBody(for: newBuilding)
    }
    
    private func copyJointDataFrom(_ oldBuilding: Building, to newBuilding: inout Building) {
        newBuilding.id = oldBuilding.id
        newBuilding.enemiesInRadius = oldBuilding.enemiesInRadius
        newBuilding.buildingNode.position = oldBuilding.buildingNode.position
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
    
    func isExistBuiling(on coordinate: (Int, Int)) -> Bool {
        buildings[coordinate.0][coordinate.1] != nil
    }
    
    func getBuilding(by coordinate: (Int, Int)) -> Building {
        return buildings[coordinate.0][coordinate.1]!
    }
    
    //MARK: SO BAD CODE.
    /// Because instances of classes are created in order to take only one property of this class. Irrational use of productivity
    /// This will need to be fixed in the future.
    func calculateCost(ofBuilding buildingType: BuildingTypes, by coordinate: (Int, Int)) -> Int {
        if isExistBuiling(on: coordinate) {
            let oldBuilding = getBuilding(by: coordinate)
            let nextLevel = getNextLevel(after: oldBuilding.level)
            let wantedBuilding = AbstactFactoryBuildingsImpl.defaultFactory
                .create(buildingType, with: nextLevel)
            return wantedBuilding.buildingCost
        } else {
            let wantedBuilding = AbstactFactoryBuildingsImpl.defaultFactory
                .create(buildingType, with: .firstLevel)
            return wantedBuilding.buildingCost
        }
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
        if buildings[coordinate.0][coordinate.1]!.enemiesInRadius
            .contains(where: {$0.id == enemy.id}){return}
        buildings[coordinate.0][coordinate.1]!.enemiesInRadius.append(enemy)
    }
    
    func remove(_ enemy: AnyEnemy, fromBuildingWith coordinate: (Int, Int)) {
        let remainingEnemies = buildings[coordinate.0][coordinate.1]!.enemiesInRadius.filter{$0.id != enemy.id}
        buildings[coordinate.0][coordinate.1]!.enemiesInRadius = remainingEnemies
    }
    
    func updateCounter() {
        if !isActive {return}
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
        pushProjectileNodeFrom(building)
        let attackedEnemy = building.enemiesInRadius.first!
        attackedEnemy.healthPoints -= building.damage
        if attackedEnemy.healthPoints <= 0 {
            delegate.enemyKilled(attackedEnemy)
            print(building.enemiesInRadius.map{$0.race})
        }
    }
    
    func stopAtack() {
        isActive = false
    }
    
    func runAtack() {
        isActive = true
    }
    
    func pushProjectileNodeFrom(_ building: Building) {
        let projectileNode = building.buildingNode.childNode(withName: NodeNames.projectileNode.rawValue, recursively: true)
        projectileNode!.removeAllActions()
        let enemyPosition = building.enemiesInRadius.first!.enemyNode.position
        let buildingPosition = building.buildingNode.position
        let endPosition = SCNVector3(enemyPosition.x - buildingPosition.x, enemyPosition.y, enemyPosition.z - buildingPosition.z)
        let duration = 0.3
        projectileNode!.position = SCNVector3(0, 0.5, 0)
        let action = SCNAction.move(to: endPosition, duration: duration)
        projectileNode!.runAction(action)
    }
    
}

