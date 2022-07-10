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
}

class BuildingsManagerImpl: BuildingsManager {
    
    var towerSelectionPanel: TowerSelectionPanel!
    var battleFieldSize: Int!
    var buildings: [[Building?]]!
    var buildingState: BuildingStates!
    
    weak var delegate: BuildingsManagerDelegate!
    
    init(_ battleFieldSize: Int) {
        self.battleFieldSize = battleFieldSize
        buildingState = .inactive
        createBuildingsArray()
        setupBuildingSelectionPanel()
    }
    
    private func createBuildingsArray() {
        let row: [Building?] = Array(repeating: nil, count: battleFieldSize)
        buildings = Array(repeating: row, count: battleFieldSize)
    }
}

// funcs for build, upgrage and remove towers
extension BuildingsManagerImpl {
    func buildTower(with type: BuildingTypes, by coordinate: (Int, Int)) {
        let building = AbstactFactoryBuildingsImpl.defaultFactory.create(type, with: .firstLevel)
        buildings[coordinate.0][coordinate.1] = building
        building.buildingNode.position = Converter.toPosition(from: coordinate)
        addPhysicsBody(for: building)
        delegate.addNodeToScene(building.buildingNode)
    }
    
    func updateTower(by coordinate: (Int, Int)) {
        let oldBuilding = getBuilding(by: coordinate)
        let type = oldBuilding.type
        let nextLevel = BuildingLevels(rawValue: oldBuilding.level.rawValue + 1) ?? .thirdLevel
        var newBuilding = AbstactFactoryBuildingsImpl.defaultFactory.create(type, with: nextLevel)
        copyJointDataFrom(oldBuilding, to: &newBuilding)
        oldBuilding.buildingNode.removeFromParentNode()
        buildings[coordinate.0][coordinate.1] = newBuilding
        addPhysicsBody(for: newBuilding)
        delegate.addNodeToScene(newBuilding.buildingNode)
    }
    
    private func copyJointDataFrom(_ oldBuilding: Building, to newBuilding: inout Building) {
        newBuilding.id = oldBuilding.id
        newBuilding.enemiesInRadius = oldBuilding.enemiesInRadius
        newBuilding.buildingNode.position = oldBuilding.buildingNode.position
    }
    
    func deleteBuilding(with coordinate: (Int, Int)) {
        buildings[coordinate.0][coordinate.1]?.buildingNode.removeFromParentNode()
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
        if buildings[coordinate.0][coordinate.1]!.enemiesInRadius
            .contains(where: {$0.id == enemy.id}){return}
        buildings[coordinate.0][coordinate.1]!.enemiesInRadius.append(enemy)
    }
    
    func remove(_ enemy: AnyEnemy, fromBuildingWith coordinate: (Int, Int)) {
        guard let _ = buildings[coordinate.0][coordinate.1] else {return}
        let remainingEnemies = buildings[coordinate.0][coordinate.1]!.enemiesInRadius.filter{$0.id != enemy.id}
        buildings[coordinate.0][coordinate.1]!.enemiesInRadius = remainingEnemies
    }
    
    func updateCounter() {
        if buildingState == .inactive {return}
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
        delegate.enemyWounded(enemy: attackedEnemy)
        if attackedEnemy.healthPoints <= 0 {
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
    
    func resetPhysicsBody(by coordinate: (Int, Int)) {
        guard let _ = buildings[coordinate.0][coordinate.1] else {return}
        buildings[coordinate.0][coordinate.1]!.buildingNode.childNode(withName: NodeNames.physicsRadiusNode.rawValue, recursively: true)?.removeFromParentNode()
        addPhysicsBody(for: buildings[coordinate.0][coordinate.1]!)
    }
    
}

// animations
extension BuildingsManagerImpl {
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

