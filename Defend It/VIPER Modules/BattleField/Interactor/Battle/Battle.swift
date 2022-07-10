//
//  Battle.swift
//  Defend It
//
//  Created by Роман Сенкевич on 17.06.22.
//

import Foundation
import SceneKit

enum BattleStates: String {
    case pause
    case play
    case win
    case lose
}

protocol BattleDelegate: AnyObject {
    func addNodeToScene(_ node: SCNNode)
    func removeNodeFromScene(with name: String)
    func displayValues(of value: BattleValueTypes, to number: Int)
}

protocol Battle {
    func startBattle()
    func playBattle()
    func stopBattle()
    func finishBattle()
    func speedUpBattle(by times: Int)
    func exitAndSaveBattle()
    
    
    func buildTower(type: BuildingTypes, by coordinate: (Int, Int))
    func upgradeTower(by coordinate: (Int, Int))
    func sellTower(by coordinate: (Int, Int))
    func repairTower(by coordinate: (Int, Int))
    func showTowerSelectionPanel(by coordinate: (Int, Int))
    func useBoost()
    
    func recognizePressedNode(_ node: SCNNode)
    func didBegin(_ nodeA: SCNNode, contactWith nodeB: SCNNode)
    func didEnd(_ nodeA: SCNNode, contactWith nodeB: SCNNode)
    func update()
    
    func displayBattleValues()
}

class BattleImpl: MeadowManagerDelagate, BuildingsManagerDelegate, Battle {
    
    private var battleState: BattleStates!
    
    var meadowManager: MeadowManager!
    var buildingsManager: BuildingsManager!
    var enemiesManager: EnemiesManager!
    var battleValuesManager: BattleManager!
    
    var battleMission: BattleMission!
    weak var delegate: BattleDelegate!
    
    var battleCounter: Int = 0
    
    init() {
        battleState = .pause
        loadBuildngs()
    }
    
    func getBattleCounter() -> Int {
        battleCounter
    }
    
    func displayBattleValues() {
        delegate.displayValues(of: .coins, to: battleValuesManager.get(.coins))
        delegate.displayValues(of: .lives, to: battleValuesManager.get(.lives))
        delegate.displayValues(of: .points, to: battleValuesManager.get(.points))
    }
    
    func startBattle() {
        changeBattleState(into: .pause)
//        enemiesManager.addEnemiesToScene()
        meadowManager.addGroundToScene()
    }
    
    func update() {
        if battleState != .play {return}
        buildingsManager.updateCounter()
        enemiesManager.updateCounter()
        battleCounter += 1
    }
    
    func loadBuildngs() {
        _ = BallistaFactory.defaultFactory
        _ = MagicTowerFactory.defaultFactory
        _ = ElphTowerFactory.defaultFactory
        _ = WallFactory.defaultFactory
    }
    
}

extension BattleImpl {
    func changeBattleState(into state: BattleStates) {
        battleState = state
    }
    
    func addNodeToScene(_ node: SCNNode) {
        delegate.addNodeToScene(node)
    }
}

// battle states
extension BattleImpl {
    func playBattle() {
        changeBattleState(into: .play)
        buildingsManager.runAtack()
        enemiesManager.runAllEnemies()
    }
    func stopBattle() {
        changeBattleState(into: .pause)
        buildingsManager.stopAtack()
        enemiesManager.stopAllEnemies()
        
    }
    func finishBattle() {
        stopBattle()
        changeBattleState(into: .lose)
    }
    func speedUpBattle(by times: Int) {
        print("add this later")
    }
    func exitAndSaveBattle() {
        changeBattleState(into: .pause)
    }
}

// capabilities
extension BattleImpl {
    func buildTower(type: BuildingTypes, by coordinate: (Int, Int)) {
        /// checks
        let tempTower = AbstactFactoryBuildingsImpl.defaultFactory.create(type, with: .firstLevel)
        if !isThereEnoughMoney(for: tempTower) {return}
        if !isThereAnEnemy(by: coordinate) {return}
        if !willTheEnemiesBeAbleToFindAWay(coordinate: coordinate) {return}
        buildingsManager.buildTower(with: type, by: coordinate)
        enemiesManager.prohibitWalking(On: coordinate)
        /// battle values
        battleValuesManager.reduce(.coins, by: tempTower.buildingCost)
        displayBattleValues()
    }
    func upgradeTower(by coordinate: (Int, Int)) {
        let oldTower = buildingsManager.getBuilding(by: coordinate)
        let type = oldTower.type
        let nextLevel: BuildingLevels = BuildingLevels(rawValue: oldTower.level.rawValue + 1) ?? .thirdLevel
        let upTower = AbstactFactoryBuildingsImpl.defaultFactory.create(type, with: nextLevel)
        /// check
        if !isThereEnoughMoney(for: upTower) {return}
        buildingsManager.updateTower(by: coordinate)
        /// battle values
        battleValuesManager.reduce(.coins, by: upTower.buildingCost)
        displayBattleValues()
    }
    func sellTower(by coordinate: (Int, Int)) {
        let oldTower = buildingsManager.getBuilding(by: coordinate)
        buildingsManager.deleteBuilding(with: coordinate)
        enemiesManager.allowWalking(On: coordinate)
        /// battle values
        battleValuesManager.increase(.coins, by: oldTower.saleCost)
        displayBattleValues()
    }
    func repairTower(by coordinate: (Int, Int)) {
        print("repair building by coordinate: \(coordinate)")
    }
    func showTowerSelectionPanel(by coordinate: (Int, Int)) {
        let node = buildingsManager.getTowerSelectionPanel(On: Converter.toPosition(from: coordinate))
        delegate.addNodeToScene(node)
    }
    func hideTowerSelectionPanel() {
        delegate.removeNodeFromScene(with: NodeNames.buildingSelectionPanel.rawValue)
    }
    func useBoost() {
        print("add boosts later")
    }
}

// interactions
extension BattleImpl: EnemiesManagerDelegate, BattleManagerDelegate {
    
    func enemyWounded(enemy: AnyEnemy) {
//        print("sound")
//        print("line of health")
    }
    func enemyMurdered(enemy: AnyEnemy) {
//        print("sound")
        DispatchQueue.main.async {
            self.battleValuesManager.increase(.coins, by: enemy.coinMurderReward)
            self.battleValuesManager.increase(.points, by: enemy.pointsMurderReward)
            self.displayBattleValues()
        }
        enemiesManager.removeEnemy(enemy)
    }
    func allEnemiesMurdered() {
        finishBattle()
    }
    func enemyReachedCastle() {
        DispatchQueue.main.async {
            self.battleValuesManager.reduce(.lives, by: 1)
            self.displayBattleValues()
        }
    }
    func livesAreOver() {
        finishBattle()
    }
    func towerDamaged() {
        print("later")
    }
    func towerDestroyed() {
        print("later")
    }
}

// checks
extension BattleImpl {
    func isThereEnoughMoney(for tower: Building) -> Bool {
        if (battleValuesManager.get(.coins) - tower.buildingCost) > 0 {
            return true
        } else {
            return false
        }
    }
    
    func willTheEnemiesBeAbleToFindAWay(coordinate: (Int, Int)) -> Bool {
        return true
    }
    func isThereAnEnemy(by coordinate: (Int, Int)) -> Bool {
        return true
    }
    func isExistTower(on coordinate: (Int, Int)) -> Bool {
        if buildingsManager.isExistBuiling(on: coordinate) {
            return true
        } else {
            return false
        }
    }
}

extension BattleImpl {
    func didBegin(_ nodeA: SCNNode, contactWith nodeB: SCNNode) {
        var enemyNode: SCNNode!
        var towerRadiusNode: SCNNode!
        
        if nodeA.physicsBody?.categoryBitMask == 1 {
            towerRadiusNode = nodeA
            enemyNode = nodeB
        } else {
            enemyNode = nodeA
            towerRadiusNode = nodeB
        }
        let coordinate = Converter.toCoordinate(from: getParentNodeFor(towerRadiusNode).position)
        guard let enemy = enemiesManager.getEnemyBy(enemyNode) else {return}
        buildingsManager.add(enemy, toBuildingWith: coordinate)
    }
    
    func didEnd(_ nodeA: SCNNode, contactWith nodeB: SCNNode) {
        var enemyNode: SCNNode!
        var towerRadiusNode: SCNNode!
        
        if nodeA.physicsBody?.categoryBitMask == 1 {
            towerRadiusNode = nodeA
            enemyNode = nodeB
        } else {
            enemyNode = nodeA
            towerRadiusNode = nodeB
        }
        let coordinate = Converter.toCoordinate(from: getParentNodeFor(towerRadiusNode).position)
        guard let enemy = enemiesManager.getEnemyBy(enemyNode) else {return}
        buildingsManager.remove(enemy, fromBuildingWith: coordinate)
    }
    
    func recognizePressedNode(_ node: SCNNode) {
        
        let parentNode = getParentNodeFor(node)
        let coordinate = Converter.toCoordinate(from: parentNode.position)
        
        switch node.name {
        case _ where node.name! == RecognitionNodes.sellSelectIcon.rawValue:
            sellTower(by: coordinate)
            hideTowerSelectionPanel()
            
        case _ where node.name! == RecognitionNodes.repairSelectIcon.rawValue:
            repairTower(by: coordinate)
            hideTowerSelectionPanel()
            
        case _ where node.name!.contains(RecognitionNodes.floor.rawValue):
            hideTowerSelectionPanel()
            
        case _ where node.name!.contains(RecognitionNodes.groundSquare.rawValue):
            showTowerSelectionPanel(by: coordinate)
            
        case _ where node.name!.contains(RecognitionNodes.selectIcon.rawValue):
            let buildingType = Converter.toBuildingType(from: node.name!)!
            isExistTower(on: coordinate) ? upgradeTower(by: coordinate) : buildTower(type: buildingType, by: coordinate)
            hideTowerSelectionPanel()
            
        case _ where node.name!.contains(RecognitionNodes.builtTower.rawValue):
            showTowerSelectionPanel(by: coordinate)
        default:
            print("default case in BattleFieldPresenter")
            break
        }
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

enum RecognitionNodes: String  {
    case floor = "floor"
    case groundSquare = "groundSquare"
    case selectIcon = "SelectIcon"
    case builtTower = "builtTower"
    case sellSelectIcon = "sellSelectIcon"
    case repairSelectIcon = "repairSelectIcon"
}
