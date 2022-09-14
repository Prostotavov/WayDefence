//
//  BuildingsManager.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import SceneKit

enum BuildingStates {
    case active
    case inactive
}

protocol BuildingsManagerDelegate: AnyObject {
    func addNodeToScene(_ node: SCNNode)
    func enemyWounded(enemy: AnyEnemy)
    func enemyMurdered(enemy: AnyEnemy)
}

protocol BuildingsManager {
    func getTowerSelectionPanel(On position: SCNVector3) -> SCNNode
    
    func isExistBuiling(on coordinate: (Int, Int)) -> Bool
    func deleteBuilding(with coordinate: (Int, Int))
    func buildTower(with type: BuildingTypes, by coordinate: (Int, Int))
    func updateTower(by coordinate: (Int, Int))
    func getBuilding(by coordinate: (Int, Int)) -> Building
    
    func updateCounter()
    func stopAtack()
    func runAtack()

    func add(_ enemy: AnyEnemy, toBuildingWith coordinate: (Int, Int))
    func remove(_ enemy: AnyEnemy, fromBuildingWith coordinate: (Int, Int))

    func resetPhysicsBody(by coordinate: (Int, Int))

    
    func showBuilding(_ type: BuildingTypes, with level: BuildingLevels, on position: SCNVector3) -> Bool
    func pan(towerNode: SCNNode, by position: SCNVector3)
    func getBuildingCards() -> [BuildingCard]
}

class BuildingsManagerImpl: BuildingsManager {
    
    var towerSelectionPanel: TowerSelectionPanel!
    var battleFieldSize: Int!
    var buildings: [[Building?]]!
    var buildingState: BuildingStates!
    
    var buildingCards: [BuildingCard] = []
    
    weak var delegate: BuildingsManagerDelegate!
    
    init(_ battleFieldSize: Int) {
        self.battleFieldSize = battleFieldSize
        buildingState = .inactive
        createBuildingsArray()
        setupBuildingSelectionPanel()
        createBuildingCards()
    }
    
    private func createBuildingsArray() {
        let row: [Building?] = Array(repeating: nil, count: battleFieldSize)
        buildings = Array(repeating: row, count: battleFieldSize)
    }
}

//MARK: func for building by pan a buildingCard
extension BuildingsManagerImpl {
    
    func getBuildingCards() -> [BuildingCard] {
        return buildingCards
    }
    
    private func createBuildingCards() {
        let elphTower = AbstactFactoryBuildingsImpl.defaultFactory.create(.elphTower, with: .firstLevel)
        let magicTower = AbstactFactoryBuildingsImpl.defaultFactory.create(.magicTower, with: .firstLevel)
        let ballistaTower = AbstactFactoryBuildingsImpl.defaultFactory.create(.ballista, with: .firstLevel)
        let wallTower = AbstactFactoryBuildingsImpl.defaultFactory.create(.wall, with: .firstLevel)
        
        buildingCards.append(BuildingCard(building: elphTower))
        buildingCards.append(BuildingCard(building: magicTower))
        buildingCards.append(BuildingCard(building: ballistaTower))
        buildingCards.append(BuildingCard(building: wallTower))
    }
    
    func showBuilding(_ type: BuildingTypes, with level: BuildingLevels, on position: SCNVector3) -> Bool {
        let building = AbstactFactoryBuildingsImpl.defaultFactory.create(type, with: level)
        
        let coordinate = Converter.toCoordinate(from: position)
        if buildings[coordinate.0][coordinate.1] != nil {return false}
        building.info.buildingNode.position = Converter.toPosition(from: coordinate)
        building.info.buildingNode.name = "shownTower"
        delegate.addNodeToScene(building.info.buildingNode)
        return true
    }

    
    func pan(towerNode: SCNNode, by position: SCNVector3) {
        let coordinate = Converter.toCoordinate(from: position)
        if buildings[coordinate.0][coordinate.1] != nil {return}
        towerNode.position = Converter.toPosition(from: coordinate)
    }
}

// funcs for build, upgrage and remove towers
extension BuildingsManagerImpl {
    

    
    func buildTower(with type: BuildingTypes, by coordinate: (Int, Int)) {
        if buildings[coordinate.0][coordinate.1] != nil {return}
        let building = AbstactFactoryBuildingsImpl.defaultFactory.create(type, with: .firstLevel)
        buildings[coordinate.0][coordinate.1] = building
        building.info.buildingNode.position = Converter.toPosition(from: coordinate)
        addPhysicsBody(for: building)
        delegate.addNodeToScene(building.info.buildingNode)
    }
    
    func updateTower(by coordinate: (Int, Int)) {
        let oldBuilding = getBuilding(by: coordinate)
        let type = oldBuilding.info.type
        let nextLevel = BuildingLevels(rawValue: oldBuilding.info.level.rawValue + 1) ?? .thirdLevel
        var newBuilding = AbstactFactoryBuildingsImpl.defaultFactory.create(type, with: nextLevel)
        copyJointDataFrom(oldBuilding, to: &newBuilding)
        oldBuilding.info.buildingNode.removeFromParentNode()
        buildings[coordinate.0][coordinate.1] = newBuilding
        addPhysicsBody(for: newBuilding)
        delegate.addNodeToScene(newBuilding.info.buildingNode)
    }
    
    private func copyJointDataFrom(_ oldBuilding: Building, to newBuilding: inout Building) {
        newBuilding.id = oldBuilding.id
        newBuilding.battleInfo.enemiesInRadius = oldBuilding.battleInfo.enemiesInRadius
        newBuilding.info.buildingNode.position = oldBuilding.info.buildingNode.position
    }
    
    func deleteBuilding(with coordinate: (Int, Int)) {
        buildings[coordinate.0][coordinate.1]?.info.buildingNode.removeFromParentNode()
        buildings[coordinate.0][coordinate.1] = nil
    }
    
    func isExistBuiling(on coordinate: (Int, Int)) -> Bool {
        buildings[coordinate.0][coordinate.1] != nil
    }
    
    func getBuilding(by coordinate: (Int, Int)) -> Building {
        return buildings[coordinate.0][coordinate.1]!
    }
}


// funcs for tower selection panel
extension BuildingsManagerImpl {
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
}


// funs for atack enemy
extension BuildingsManagerImpl {
    func add(_ enemy: AnyEnemy, toBuildingWith coordinate: (Int, Int)) {
        guard let _ = buildings[coordinate.0][coordinate.1] else {return}
        if buildings[coordinate.0][coordinate.1]!.battleInfo.enemiesInRadius
            .contains(where: {$0.id == enemy.id}){return}
        buildings[coordinate.0][coordinate.1]!.battleInfo.enemiesInRadius.append(enemy)
    }
    
    func remove(_ enemy: AnyEnemy, fromBuildingWith coordinate: (Int, Int)) {
        guard let _ = buildings[coordinate.0][coordinate.1] else {return}
        let remainingEnemies = buildings[coordinate.0][coordinate.1]!.battleInfo.enemiesInRadius.filter{$0.id != enemy.id}
        buildings[coordinate.0][coordinate.1]!.battleInfo.enemiesInRadius = remainingEnemies
    }
    
    func updateCounter() {
        if buildingState == .inactive {return}
        for (x, _) in buildings.enumerated() {
            for (z, _) in buildings[x].enumerated() {
                if buildings[x][z] == nil  { continue }
                if buildings[x][z]!.battleInfo.counter != 0 { buildings[x][z]?.battleInfo.counter -= 1; continue }
                if buildings[x][z]!.battleInfo.enemiesInRadius == [] { continue }
                buildings[x][z]!.battleInfo.counter = Converter.toCounter(from: buildings[x][z]!.parameter.attackSpeed)
                attackEnemy(by: buildings[x][z]!)
            }
        }
    }
    
    func attackEnemy(by building: Building) {
        pushProjectileNodeFrom(building)
        guard let attackedEnemy = building.battleInfo.enemiesInRadius.first else {return}
        attackedEnemy.currentHealthPoints -= building.parameter.damage
        delegate.enemyWounded(enemy: attackedEnemy)
        if attackedEnemy.currentHealthPoints <= 0 {
            delegate.enemyMurdered(enemy: attackedEnemy)
        }
    }
    
    func stopAtack() {
        buildingState = .inactive
    }
    
    func runAtack() {
        buildingState = .active
    }
}

// funcs for add physics
extension BuildingsManagerImpl {
    func addPhysicsBody(for building: Building) {
        let physicsShape = SCNPhysicsShape(geometry: SCNSphere(radius: building.parameter.radius / 3))
        let physicsBody = SCNPhysicsBody(type: .kinematic, shape: physicsShape)
        
        physicsBody.isAffectedByGravity = false
        physicsBody.categoryBitMask = 1
        physicsBody.contactTestBitMask = 2
        
        let physicsRadiusNode = SCNNode()
        physicsRadiusNode.name = NodeNames.physicsRadiusNode.rawValue
        physicsRadiusNode.physicsBody = physicsBody
        building.info.buildingNode.addChildNode(physicsRadiusNode)
    }
    
    func resetPhysicsBody(by coordinate: (Int, Int)) {
        guard let _ = buildings[coordinate.0][coordinate.1] else {return}
        buildings[coordinate.0][coordinate.1]!.info.buildingNode.childNode(withName: NodeNames.physicsRadiusNode.rawValue, recursively: true)?.removeFromParentNode()
        addPhysicsBody(for: buildings[coordinate.0][coordinate.1]!)
    }
    
}

// animations
extension BuildingsManagerImpl {
    func pushProjectileNodeFrom(_ building: Building) {
        let projectileNode = building.info.buildingNode.childNode(withName: NodeNames.projectileNode.rawValue, recursively: true)
        projectileNode!.removeAllActions()
        guard let enemyPosition = building.battleInfo.enemiesInRadius.first?.enemyNode.position else {return}
        let buildingPosition = building.info.buildingNode.position
        let endPosition = SCNVector3(enemyPosition.x - buildingPosition.x, enemyPosition.y, enemyPosition.z - buildingPosition.z)
        let duration = 0.3
        projectileNode!.position = SCNVector3(0, 0.5, 0)
        let action = SCNAction.move(to: endPosition, duration: duration)
        projectileNode!.runAction(action)
    }
}

