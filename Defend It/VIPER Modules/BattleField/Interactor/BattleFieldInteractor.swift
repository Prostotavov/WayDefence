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
    var battleValuesManager: BattleValuesManager!
    var camerasManager: CamerasManager!
    
    func loadView() {
        setupCamera()
        setupMeadow()
        setupEnemies()
        loadBuildngs()
    }
    
    func viewDidAppear() {
        set(.coins)
        set(.lives)
        set(.points)
    }
    
    func setupCamera() {
        output.add(camerasManager.parentCameraNode)
        output.setupPointOfView(from: camerasManager.chieldCameraNode)
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
    
    func loadBuildngs() {
        _ = BallistaFactory.defaultFactory
        _ = MagicTowerFactory.defaultFactory
        _ = ElphTowerFactory.defaultFactory
        _ = WallFactory.defaultFactory
    }
    
    func getParentNodeFor(_ childNode: SCNNode) -> SCNNode {
        var parentNode: SCNNode!
        if childNode.parent?.parent != nil {
            parentNode = getParentNodeFor(childNode.parent!)
        } else {
            parentNode = childNode
        }
        return parentNode
    }
}


// func for switch
extension BattleFieldInteractor {
    
    func sellBuilding(on position: SCNVector3) {
        let coordinate = Converter.toCoordinate(from: position)
        let building = buildingsManager.getBuilding(by: coordinate)
        buildingsManager.deleteBuilding(with: coordinate)
        enemiesManager.allowWalking(On: coordinate)
        increase(.coins, by: building.saleCost)
        output.remove(building.buildingNode)
    }
    
    func repairBuilding(on position: SCNVector3) {
        print("repairBuilding on \(position)")
    }
    
    func hideTowerSelectionPanel() {
        output.removeNode(with: NodeNames.buildingSelectionPanel.rawValue)
    }
    
    func showTowerSelectionPanel(on position: SCNVector3) {
        let panel = buildingsManager.getTowerSelectionPanel(On: position)
        output.add(panel)
    }
    
    func build(_ buildingType: BuildingTypes, on position: SCNVector3) {
        if !checkIfEnounghMoney(forBuilding: buildingType, on : position) {return}
        let coordinate = Converter.toCoordinate(from: position)
        enemiesManager.prohibitWalking(On: coordinate)
        
        var building: Building!
        if buildingsManager.isExistBuiling(on: coordinate) {
            buildingsManager.updateBuilding(by: coordinate)
            building = buildingsManager.getBuilding(by: coordinate)
        } else {
            buildingsManager.build(buildingType, by: coordinate)
            building = buildingsManager.getBuilding(by: coordinate)
        }
        output.add(building.buildingNode)
        hideTowerSelectionPanel()
        reduce(.coins, by: buildingsManager.getBuilding(by: coordinate).buildingCost)
    }
    
    private func checkIfEnounghMoney(forBuilding buildingType: BuildingTypes,
                                     on position: SCNVector3) -> Bool {
        let coordinate = Converter.toCoordinate(from: position)
        let buildingCost = buildingsManager.calculateCost(ofBuilding: buildingType, by: coordinate)
        let currentCoins = battleValuesManager.get(.coins)
        return (currentCoins - buildingCost >= 0) ? true : false
    }
}

// cameras
extension BattleFieldInteractor {
    func deviceOrientationChanged(to orientation: UIDeviceOrientation) {
        switch orientation {
        case .portrait:
            camerasManager.switchToVerticalCamera()
            output.setupPointOfView(from: camerasManager.chieldCameraNode)
            output.setViewVerticalOrientation()
        default :
            camerasManager.switchToHorisontalCamera()
            output.setupPointOfView(from: camerasManager.chieldCameraNode)
            output.setViewHorisontalOrientation()
        }
    }
}

extension BattleFieldInteractor {
    
    func newFrameDidRender() {
        buildingsManager.updateCounter()
        enemiesManager.updateCounter()
    }
    
    func didBegin(_ enemyNode: SCNNode, contactWith radiusNode: SCNNode) {
        let coordinate = Converter.toCoordinate(from: getParentNodeFor(radiusNode).position)
        guard let enemy = enemiesManager.getEnemyBy(enemyNode) else {return}
        buildingsManager.add(enemy, toBuildingWith: coordinate)
    }
    
    func didEnd(_ enemyNode: SCNNode, contactWith radiusNode: SCNNode) {
        let coordinate = Converter.toCoordinate(from: getParentNodeFor(radiusNode).position)
        guard let enemy = enemiesManager.getEnemyBy(enemyNode) else {return}
        buildingsManager.remove(enemy, fromBuildingWith: coordinate)
    }
    
    func remove(_ enemy: AnyEnemy) {
        DispatchQueue.main.async {
            self.increase(.coins, by: enemy.coinMurderReward)
        }
        enemiesManager.removeEnemy(enemy)
    }
}

extension BattleFieldInteractor {
    
    func set(_ value: BattleValues) {
        let number = battleValuesManager.get(value)
        output.set(value, to: number)
    }
    
    func increase(_ value: BattleValues, by number: Int) {
        battleValuesManager.increase(value, by: number)
        let number = battleValuesManager.get(value)
        output.set(value, to: number)
    }
    
    func reduce(_ value: BattleValues, by number: Int) {
        battleValuesManager.reduce(value, by: number)
        let number = battleValuesManager.get(value)
        output.set(value, to: number)
    }
}

//MARK: bad code
extension BattleFieldInteractor {
    
    func fixCurrentPosition() {
        camerasManager.fixCurrentPosition()
    }
    
    func dragCamera(by position: SCNVector3) {
        camerasManager.dragCamera(by: position)
        output.setupPointOfView(from: camerasManager.chieldCameraNode)
    }
}

extension BattleFieldInteractor {
    func stopGame() {
        enemiesManager.stopAllEnemies()
        buildingsManager.stopAtack()
    }
    
    func playGame() {
        enemiesManager.runAllEnemies()
        buildingsManager.runAtack()
    }
}
