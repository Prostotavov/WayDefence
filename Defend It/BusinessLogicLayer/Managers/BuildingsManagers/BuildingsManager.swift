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
    func getBuilding(by coordinate: (Int, Int)) -> AnyBuilding?
    
    func updateCounter()
    func stopAtack()
    func runAtack()

    func add(_ enemy: AnyEnemy, toBuildingWith coordinate: (Int, Int))
    func remove(_ enemy: AnyEnemy, fromBuildingWith coordinate: (Int, Int))

    func resetPhysicsBody(by coordinate: (Int, Int))

    
    func showBuilding(_ card: BuildingCard, on position: SCNVector3) -> Bool
    func pan(_ buildingCard: BuildingCard, by position: SCNVector3)
    func getBuildingCards() -> [BuildingCard]
}

class BuildingsManagerImpl: BuildingsManager {
    
    var towerSelectionPanel: TowerSelectionPanel!
    var battleFieldSize: Int!
    
    var buildings: Set<AnyBuilding> = []
    
    var buildingState: BuildingStates!
    
    var buildingCards: [BuildingCard] = []
    
    private var shownBuilding: AnyBuilding?
    
    weak var delegate: BuildingsManagerDelegate!
    
    init(_ battleFieldSize: Int) {
        self.battleFieldSize = battleFieldSize
        buildingState = .inactive
        setupBuildingSelectionPanel()
        createBuildingCards()
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
    
    func showBuilding(_ card: BuildingCard, on position: SCNVector3) -> Bool {
        let coordinate = Converter.toCoordinate(from: position)
        card.appearance.buildingNode.position = Converter.toPosition(from: coordinate)
        card.appearance.buildingNode.name = "shownTower"
        delegate.addNodeToScene(card.appearance.buildingNode)
        return true
    }
    
    
    func pan(_ buildingCard: BuildingCard, by position: SCNVector3) {
        let coordinate = Converter.toCoordinate(from: position)
        buildingCard.appearance.buildingNode.position = Converter.toPosition(from: coordinate)
    }
}

// funcs for build, upgrage and remove towers
extension BuildingsManagerImpl {
    
    func buildTower(with type: BuildingTypes, by coordinate: (Int, Int)) {
        let building = AbstactFactoryBuildingsImpl.defaultFactory.create(type, with: .firstLevel)
        building.battleInfo.coordinate = coordinate
        buildings.insert(building)
        building.appearance.buildingNode.position = Converter.toPosition(from: coordinate)
        addPhysicsBody(for: building)
        delegate.addNodeToScene(building.appearance.buildingNode)
    }
    
    func updateTower(by coordinate: (Int, Int)) {
        guard let oldBuilding = getBuilding(by: coordinate) else {return}
        let type = oldBuilding.info.type
        let nextLevel = BuildingLevels(rawValue: oldBuilding.info.level.rawValue + 1) ?? .thirdLevel
        var newBuilding = AbstactFactoryBuildingsImpl.defaultFactory.create(type, with: nextLevel)
        copyJointDataFrom(oldBuilding, to: &newBuilding)
        oldBuilding.appearance.buildingNode.removeFromParentNode()
        buildings.remove(oldBuilding)
        buildings.insert(newBuilding)
        addPhysicsBody(for: newBuilding)
        delegate.addNodeToScene(newBuilding.appearance.buildingNode)
    }
    
    private func copyJointDataFrom(_ oldBuilding: AnyBuilding, to newBuilding: inout AnyBuilding) {
        newBuilding.id = oldBuilding.id
        newBuilding.battleInfo = oldBuilding.battleInfo
        newBuilding.appearance.buildingNode.position = oldBuilding.appearance.buildingNode.position
    }
    
    func deleteBuilding(with coordinate: (Int, Int)) {
        guard let building = getBuilding(by: coordinate) else {return}
        building.appearance.buildingNode.removeFromParentNode()
        buildings.remove(building)
    }
    
    
    func isExistBuiling(on coordinate: (Int, Int)) -> Bool {
        guard let _ = getBuilding(by: coordinate) else {return false}
        return true
    }
    
    func getBuilding(by coordinate: (Int, Int)) -> AnyBuilding? {
        for building in buildings {
            let buildingCoordinate = building.battleInfo.coordinate
            let size = building.appearance.size
            let oppositeCoordinate: (Int, Int) = (buildingCoordinate.0 - size.0 + 1,
                                                  buildingCoordinate.1 - size.1 + 1)
            
            if (oppositeCoordinate.0...buildingCoordinate.0).contains(coordinate.0) {
                if (oppositeCoordinate.1...buildingCoordinate.1).contains(coordinate.1) {
                    return building
                }
            }
        }
        return nil
    }
}


// funcs for tower selection panel
extension BuildingsManagerImpl {
    private func setupBuildingSelectionPanel() {
        towerSelectionPanel = TowerSelectionPanelImpl()
    }
    
    func getTowerSelectionPanel(On position: SCNVector3) -> SCNNode {
        let coordinate = Converter.toCoordinate(from: position)
        guard let building = getBuilding(by: coordinate) else {
            return towerSelectionPanel.show(on: position)
        }
        return towerSelectionPanel.show(for: building)
    }
}


// funs for atack enemy
extension BuildingsManagerImpl {
    func add(_ enemy: AnyEnemy, toBuildingWith coordinate: (Int, Int)) {
        guard let building = getBuilding(by: coordinate) else {return}
        if building.battleInfo.enemiesInRadius.contains(where: {$0.id == enemy.id}){return}
        building.battleInfo.enemiesInRadius.append(enemy)
    }
    
    //MARK: need to impove
    func remove(_ enemy: AnyEnemy, fromBuildingWith coordinate: (Int, Int)) {
        guard let building = getBuilding(by: coordinate) else {return}
        let remainingEnemies = building.battleInfo.enemiesInRadius.filter{$0.id != enemy.id}
        building.battleInfo.enemiesInRadius = remainingEnemies
    }
    
    func updateCounter() {
        if buildingState == .inactive {return}
        for building in buildings {
            if building.battleInfo.counter != 0 { building.battleInfo.counter -= 1; continue }
            if building.battleInfo.enemiesInRadius == [] { continue }
            building.battleInfo.counter = Converter.toCounter(from: building.parameter.attackSpeed)
            attackEnemy(by: building)
        }
        
    }
    
    func attackEnemy(by building: AnyBuilding) {
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
    func addPhysicsBody(for building: AnyBuilding) {
        let physicsShape = SCNPhysicsShape(geometry: SCNSphere(radius: building.parameter.radius / 3))
        let physicsBody = SCNPhysicsBody(type: .kinematic, shape: physicsShape)
        
        physicsBody.isAffectedByGravity = false
        physicsBody.categoryBitMask = 1
        physicsBody.contactTestBitMask = 2
        
        let physicsRadiusNode = SCNNode()
        physicsRadiusNode.name = NodeNames.physicsRadiusNode.rawValue
        physicsRadiusNode.physicsBody = physicsBody
        building.appearance.buildingNode.addChildNode(physicsRadiusNode)
    }
    
    func resetPhysicsBody(by coordinate: (Int, Int)) {
        guard let building = getBuilding(by: coordinate) else {return}
        building.appearance.buildingNode.childNode(withName: NodeNames.physicsRadiusNode.rawValue, recursively: true)?.removeFromParentNode()
        addPhysicsBody(for: building)
    }
    
}

// animations
extension BuildingsManagerImpl {
    func pushProjectileNodeFrom(_ building: AnyBuilding) {
        let projectileNode = building.appearance.buildingNode.childNode(withName: NodeNames.projectileNode.rawValue, recursively: true)
        projectileNode!.removeAllActions()
        guard let enemyPosition = building.battleInfo.enemiesInRadius.first?.enemyNode.position else {return}
        let buildingPosition = building.appearance.buildingNode.position
        var endPosition = SCNVector3(enemyPosition.x - buildingPosition.x, enemyPosition.y, enemyPosition.z - buildingPosition.z)
        
        if building.info.type == .magicTower &&  building.info.level == .firstLevel {
            endPosition = endPosition * 500
            endPosition.z = -endPosition.z
            projectileNode!.position = SCNVector3(0, -250, 0)
        } else {
            projectileNode!.position = SCNVector3(0, 0.5, 0)
        }

        let duration = 0.3
        let action = SCNAction.move(to: endPosition, duration: duration)
        projectileNode!.runAction(action)
    }
}

extension SCNVector3 {
    
    static func *(_ scnVector3: SCNVector3, _ value: Float) -> SCNVector3 {
        SCNVector3(scnVector3.x * value, scnVector3.y * value, scnVector3.z * value)
    }
    
}

