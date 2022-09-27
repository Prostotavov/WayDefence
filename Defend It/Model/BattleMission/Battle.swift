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

protocol BattleOutput: AnyObject {
    func finishBattle()
    func battleIsWon()
    func battleIsLost()
    func battleSpeedChanged(into newSpeed: Int)
}

protocol BattleDelegate: AnyObject {
    func addNodeToScene(_ node: SCNNode)
    func removeNodeFromScene(with name: String)
    func displayValues(of value: EconomicBattleValueTypes, to number: Int)
}

protocol Battle {
    func startBattle()
    func playBattle()
    func stopBattle()
    func finishBattle()
    func exitAndSaveBattle()
    
    
    func buildTower(type: BuildingTypes, by coordinate: (Int, Int))
    func upgradeTower(by coordinate: (Int, Int))
    func sellTower(by coordinate: (Int, Int))
    func repairTower(by coordinate: (Int, Int))
    func showTowerSelectionPanel(by coordinate: (Int, Int))
    func useBoost()
    
    func panGestureOccurred()
    func recognizePressedNode(_ node: SCNNode)
    func didBegin(_ nodeA: SCNNode, contactWith nodeB: SCNNode)
    func didEnd(_ nodeA: SCNNode, contactWith nodeB: SCNNode)
    func update()
    
    func displayBattleValues()
    func changeBattleSpeed()
    
    func showBuilding(_ card: BuildingCard, on position: SCNVector3) -> Bool
    func pan(_ buildingCard: BuildingCard, by position: SCNVector3)
    func getBuildingCards() -> [BuildingCard]
    
    var output: BattleOutput! {get set}
}

class BattleImpl: MeadowManagerDelagate, BuildingsManagerDelegate, Battle {
    
    private var battleState: BattleStates!
    
    var meadowManager: MeadowManager!
    var buildingsManager: BuildingsManager!
    var enemiesManager: EnemiesManager!
    var battleValuesManager: BattleManager!
    
    var battleMission: BattleMission!
    weak var delegate: BattleDelegate!
    
    weak var output: BattleOutput!
    
    var battleCounter: Int = 0
    var battleSpeed: Int = 0
    
    init() {
        battleState = .pause
        loadBuildngs()
    }
    
    func changeBattleSpeed() {
        if (battleSpeed == 1) {
            battleSpeed = 0
            stopBattle()
        } else {
            battleSpeed += 1
            playBattle()
        }
        output.battleSpeedChanged(into: battleSpeed)
    }
    
    func getBattleCounter() -> Int {
        battleCounter
    }
    
    func displayBattleValues() {
        delegate.displayValues(of: .coins, to: battleValuesManager.battleValues.get(.coins))
        delegate.displayValues(of: .lives, to: battleValuesManager.battleValues.get(.lives))
        delegate.displayValues(of: .points, to: battleValuesManager.battleValues.get(.points))
    }
    
    func startBattle() {
        changeBattleState(into: .pause)
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
        switch battleState {
        case .win: output.battleIsWon()
        case .lose: output.battleIsLost()
        default: output.finishBattle()
        }
        stopBattle()
    }
    func exitAndSaveBattle() {
        changeBattleState(into: .pause)
    }
}

//MARK: func for building by pan a buildingCard
extension BattleImpl {
    func getBuildingCards() -> [BuildingCard] {
        return buildingsManager.getBuildingCards()
    }
    
    func showBuilding(_ card: BuildingCard, on position: SCNVector3) -> Bool {
        var coordinate = Converter.toCoordinate(from: position)
        if !meadowManager.isEmpty(coordinate: &coordinate, forBuildingWith: card.appearance.size) {return false}
        return buildingsManager.showBuilding(card, on: position)
    }
    
    func pan(_ buildingCard: BuildingCard, by position: SCNVector3) {
        
        let previouslyCoordinate =  Converter.toCoordinate(from: buildingCard.appearance.buildingNode.position)
        var newCoordinate: (Int, Int)
        var currentCoordinate = Converter.toCoordinate(from: position)
        
        if meadowManager.isEmpty(coordinate: &currentCoordinate, forBuildingWith: buildingCard.appearance.size) {
            buildingCard.appearance.buildingNode.position = Converter.toPosition(from: currentCoordinate)
            return
        }
        
        guard let building = buildingsManager.getBuilding(by: currentCoordinate)  else {return}
        
        let differenceByX = previouslyCoordinate.0 - currentCoordinate.0
        let differenceByY = previouslyCoordinate.1 - currentCoordinate.1
        
        if abs(differenceByX) > abs(differenceByY) { // sticking to the left or right side
             
            if differenceByX > 0 {
                /// attach the new tower to the **RIGHT** side of the old tower
                newCoordinate = (building.battleInfo.coordinate.0 + building.appearance.size.0,
                                 building.battleInfo.coordinate.1)
                
            } else {
                /// attach the new tower to the **LEFT** side of the old tower
                newCoordinate = (building.battleInfo.coordinate.0 - building.appearance.size.0,
                                 building.battleInfo.coordinate.1)
            }
            
        } else { // sticking to the top or bottom side
            
            if differenceByY > 0 {
                /// attach the new tower to the **BOTTOM** side of the old tower
                newCoordinate = (building.battleInfo.coordinate.0,
                                 building.battleInfo.coordinate.1 + building.appearance.size.1)
            } else {
                /// attach the new tower to the **TOP** side of the old tower
                newCoordinate = (building.battleInfo.coordinate.0,
                                 building.battleInfo.coordinate.1 - building.appearance.size.1)
            }
            
        }
        /// **Moving A Building**
        buildingCard.appearance.buildingNode.position = Converter.toPosition(from: newCoordinate)
        return

    }
    
    
}


// capabilities
extension BattleImpl {
    func buildTower(type: BuildingTypes, by coordinate: (Int, Int)) {
        /// temp tower for provide the checks
        let tempTower = AbstactFactoryBuildingsImpl.defaultFactory.create(type, with: .firstLevel)
        var coordinate = coordinate // create var coordinate because we need to mutate this value
        /// checks
        if !meadowManager.isEmpty(coordinate: &coordinate, forBuildingWith: tempTower.appearance.size) {return}
        if !isThereEnoughMoney(for: tempTower) {return}
        if !isThereAnEnemy(by: coordinate) {return}
        if !willTheEnemiesBeAbleToFindAWay(coordinate: coordinate) {return}
        /// actions
        buildingsManager.buildTower(with: type, by: coordinate)
        enemiesManager.prohibitWalking(on: coordinate, byBuildingWith: tempTower.appearance.size)
        meadowManager.oppury(coordinate: coordinate, byBuildingWith: tempTower.appearance.size)
        /// battle values
        battleValuesManager.battleValues.reduce(.coins, by: tempTower.parameter.buildingCost)
        displayBattleValues()
    }
    func upgradeTower(by coordinate: (Int, Int)) {
        guard let oldTower = buildingsManager.getBuilding(by: coordinate) else {return}
        let type = oldTower.info.type
        let nextLevel: BuildingLevels = BuildingLevels(rawValue: oldTower.info.level.rawValue + 1) ?? .thirdLevel
        let upTower = AbstactFactoryBuildingsImpl.defaultFactory.create(type, with: nextLevel)
        /// check
        if !isThereEnoughMoney(for: upTower) {return}
        buildingsManager.updateTower(by: coordinate)
        /// battle values
        battleValuesManager.battleValues.reduce(.coins, by: upTower.parameter.buildingCost)
        displayBattleValues()
    }
    func sellTower(by coordinate: (Int, Int)) {
        guard let oldTower = buildingsManager.getBuilding(by: coordinate) else {return}
        buildingsManager.deleteBuilding(with: coordinate)
        enemiesManager.allowWalking(on: coordinate, byBuildingWith: oldTower.appearance.size)
        meadowManager.free(coordinate: coordinate, byBuildingWith: oldTower.appearance.size)
        /// battle values
        battleValuesManager.battleValues.increase(.coins, by: oldTower.parameter.saleCost)
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
extension BattleImpl: EnemiesManagerOutput, BattleManagerDelegate {
    
    func enemyWounded(enemy: AnyEnemy) {
        enemiesManager.enemyWounded(enemy: enemy)
//        print("sound")
//        print("line of health")
    }
    func enemyMurdered(enemy: AnyEnemy) {
//        print("sound")
        DispatchQueue.main.async {
            self.battleValuesManager.battleValues.increase(.coins, by: enemy.coinMurderReward)
            self.battleValuesManager.battleValues.increase(.points, by: enemy.pointsMurderReward)
            self.displayBattleValues()
            if self.battleMission.countOfEnemies != 1 {
                self.battleMission.countOfEnemies -= 1
            } else {
                self.changeBattleState(into: .win)
                self.finishBattle()
            }
        }
        enemiesManager.removeEnemy(enemy)
    }
    func allEnemiesMurdered() {
        print("allEnemiesMurdered")
        changeBattleState(into: .win)
        finishBattle()
    }
    func enemyReachedCastle() {
        DispatchQueue.main.async {
            self.battleValuesManager.battleValues.reduce(.lives, by: 1)
            self.displayBattleValues()
            
            if self.battleMission.countOfEnemies != 1 {
                self.battleMission.countOfEnemies -= 1
            } else {
                if self.battleValuesManager.battleValues.get(.lives) == 0 {
                    self.changeBattleState(into: .lose)
                } else {
                    self.changeBattleState(into: .win)
                }
                self.finishBattle()
            }
        }
    }
    func livesAreOver() {
        changeBattleState(into: .lose)
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
    func isThereEnoughMoney(for tower: AnyBuilding) -> Bool {
        if (battleValuesManager.battleValues.get(.coins) - tower.parameter.buildingCost) > 0 {
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
    func panGestureOccurred() {
        hideTowerSelectionPanel()
    }
    
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
        /// It is absolutely necessary that the parent of the node is a tower.
        /// If this is not the case, it means that the physics engine handled the collision of objects incorrectly
        if getParentNodeFor(towerRadiusNode).name!.contains("Radius") {return}
        let coordinate = Converter.toCoordinate(from: getParentNodeFor(towerRadiusNode).position)
        guard let enemy = enemiesManager.getEnemyBy(enemyNode) else {return}
        /// if nodeA is a radius, then touching objects is handled incorrectly. So you need to re-set the physical body for the radius
        if nodeA.name!.contains("Radius") {
            let coordinate = Converter.toCoordinate(from: getParentNodeFor(nodeA).position)
            buildingsManager.resetPhysicsBody(by: coordinate)
        }
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
        // node.name? must be
        guard let nodeName = node.name else {return}
        switch node.name {
        case _ where nodeName == RecognitionNodes.sellSelectIcon.rawValue:
            sellTower(by: coordinate)
            hideTowerSelectionPanel()
            
        case _ where nodeName == RecognitionNodes.repairSelectIcon.rawValue:
            repairTower(by: coordinate)
            hideTowerSelectionPanel()
            
        case _ where nodeName.contains(RecognitionNodes.floor.rawValue):
            hideTowerSelectionPanel()
            
        case _ where nodeName.contains(RecognitionNodes.groundSquare.rawValue):
            showTowerSelectionPanel(by: coordinate)
            
        case _ where nodeName.contains(RecognitionNodes.selectIcon.rawValue):
            let buildingType = Converter.toBuildingType(from: nodeName)!
            isExistTower(on: coordinate) ? upgradeTower(by: coordinate) : buildTower(type: buildingType, by: coordinate)
            hideTowerSelectionPanel()
            
        case _ where nodeName.contains(RecognitionNodes.builtTower.rawValue):
            showTowerSelectionPanel(by: coordinate)
        default:
            print("default case in BattleFieldPresenter")
            print(node.name)
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
