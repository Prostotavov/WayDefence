// 
//  BattleFieldInteractor.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation
import SceneKit

class BattleFieldInteractor: BattleFieldInteractorInput, BuildingsManagerDelegate {
    
    weak var output: BattleFieldInteractorOutput!
    var meadowManager: MeadowManager!
    var buildingsManager: BuildingsManager!
    var enemiesManager: EnemiesManager!
    
    var cameras: Cameras = CamerasImpl()
    
    func loadView() {
        setupCamera()
        setupMeadow()
        setupEnemies()
//        loadFactories()
    }
    
    func setupCamera() {
        output.add(cameras.scnVerticalNode)
    }
    
    func setupMeadow() {
        for squaresRow in meadowManager.getGroundSquares() {
            for square in squaresRow {
                output.add(square.scnNode)
            }
        }
    }
    
    func setupEnemies() {
        for enemy in enemiesManager.enemies {
            output.add(enemy.enemyNode)
        }
    }
    
    func loadFactories() {
        MagicTowerFactory.defaultFactory
        ElphTowerFactory.defaultFactory
        BallistaFactory.defaultFactory
        WallFactory.defaultFactory
    }
    
    func handlePressed(_ node: SCNNode) {
        switch node.name {
        case _ where node.name! == RecognitionNodes.sellSelectIcon.rawValue:
            sellIconPressed(by: node)
            
        case _ where node.name! == RecognitionNodes.repairSelectIcon.rawValue:
            repairIconPressed(by: node)

        case _ where node.name!.contains(RecognitionNodes.floor.rawValue):
            floorPressed()
            
        case _ where node.name!.contains(RecognitionNodes.groundSquare.rawValue):
            groundSquarePressed(by: node)
            
        case _ where node.name!.contains(RecognitionNodes.selectIcon.rawValue):
            buildingIconPressed(by: node)
            
        case _ where node.name!.contains(RecognitionNodes.builtTower.rawValue):
            builtTowerPressed(by: node)
        default:
            enemiesManager.runEnemies()
            break
        }
    }
    
    func createTowerSelectionPanel(with position: SCNVector3) -> SCNNode {
        buildingsManager.showTowerSelectionPanel(On: position)
    }
    
    func getPerentNodeFor(_ childNode: SCNNode) -> SCNNode {
        var parentNode: SCNNode!
        if childNode.parent?.parent != nil {
            parentNode = getPerentNodeFor(childNode.parent!)
        } else {
            parentNode = childNode
        }
        return parentNode
    }
    
    func getRootNodeNameFrom(_ node: SCNNode) -> String {
        var rootNodeName: String!
        if node.parent?.parent != nil {
            rootNodeName = getRootNodeNameFrom(node.parent!)
        } else {
            rootNodeName = node.name
        }
        return rootNodeName
    }
    
    func build(_ building: BuildingTypes, On position: SCNVector3) ->  SCNNode {
        enemiesManager.prohibitWalking(On: Converter.toCoordinate(from: position))
        let building = buildingsManager.create(building, with: .firstLevel, and: position).buildingNode
        return building
    }
}


// func for switch
extension BattleFieldInteractor {
    
    func sellIconPressed(by node: SCNNode) {
        let position = getPerentNodeFor(node).position
        let coordinate = Converter.toCoordinate(from: position)
        let buildingNode = buildingsManager.getBuilding(with: coordinate).buildingNode
        let selectionPanelNode = getPerentNodeFor(node)
        buildingsManager.deleteBuilding(with: coordinate)
        output.remove(buildingNode)
        output.remove(selectionPanelNode)
        
        enemiesManager.allowWalking(On: coordinate)
    }
    
    func repairIconPressed(by node: SCNNode) {
        print("repairIconPressed by -\(node.name!)- node")
    }
    
    func floorPressed() {
        output.removeNode(with: NodeNames.buildingSelectionPanel.rawValue)
    }
    
    func groundSquarePressed(by node: SCNNode) {
        let position = getPerentNodeFor(node).position
        output.add(createTowerSelectionPanel(with: position))
    }
    
    func buildingIconPressed(by node: SCNNode) {
        let position = getPerentNodeFor(node).position
        let name = node.name!
        let coordinate = Converter.toCoordinate(from: position)
        let selectionPanelNode = getPerentNodeFor(node)
        var building: SCNNode
        
        if buildingsManager.isExistBuiling(on: coordinate) {
            let oldBuilding = buildingsManager.getBuilding(with: coordinate)
            output.remove(oldBuilding.buildingNode)
            building = buildingsManager.getUpgradeBuilding(for: coordinate).buildingNode
        } else {
            let buildingType = Converter.toBuildingType(from: name)!
            building = build(buildingType, On: position)
        }
        output.add(building)
        output.remove(selectionPanelNode)
    }
    
    func builtTowerPressed(by node: SCNNode) {
        let position = getPerentNodeFor(node).position
        let panel = buildingsManager.showTowerSelectionPanel(On: position)
        output.add(panel)
    }
}

enum RecognitionNodes: String  {
    case floor = "floor"
    case groundSquare = "groundSquare"
    case selectIcon = "SelectIcon"
    case builtTower = "builtTower"
    case sellSelectIcon = "sellSelectIcon"
    case repairSelectIcon = "repairSelectIcon"
}

// cameras
extension BattleFieldInteractor {
    func deviceOrientationChanged(to orientation: UIDeviceOrientation) {
        switch orientation {
        case .portrait:
            output.setupPointOfView(from: cameras.scnVerticalNode)
            output.setViewVerticalOrientation()
        default :
            output.setupPointOfView(from: cameras.scnHorisontalNode)
            output.setViewHorisontalOrientation()
        }
    }
}

extension BattleFieldInteractor {
    func newFrameDidRender() {
        buildingsManager.updateCounter()
        enemiesManager.updateCounter()
    }
}

extension BattleFieldInteractor {
    func didBegin(_ enemyNode: SCNNode, contactWith radiusNode: SCNNode) {
        let coordinate = Converter.toCoordinate(from: getPerentNodeFor(radiusNode).position)
        let enemy = enemiesManager.getEnemyBy(enemyNode)
        buildingsManager.add(enemy, toBuildingWith: coordinate)
    }
    
    func didEnd(_ enemyNode: SCNNode, contactWith radiusNode: SCNNode) {
        let coordinate = Converter.toCoordinate(from: getPerentNodeFor(radiusNode).position)
        let enemy = enemiesManager.getEnemyBy(enemyNode)
        buildingsManager.remove(enemy, fromBuildingWith: coordinate)
    }
}

extension BattleFieldInteractor {
    func remove(_ enemy: AnyEnemy) {
        enemiesManager.removeEnemy(enemy)
    }
}
