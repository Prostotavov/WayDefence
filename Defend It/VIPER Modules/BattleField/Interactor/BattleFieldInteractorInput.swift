// 
//  BattleFieldInteractorInput.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation
import SceneKit

protocol BattleFieldInteractorInput: AnyObject {
    
    func loadView()
    func viewDidAppear()
    func deviceOrientationChanged(to orientation: UIDeviceOrientation)
    func newFrameDidRender()
    func didBegin(_ enemyNode: SCNNode, contactWith radiusNode: SCNNode)
    func didEnd(_ enemyNode: SCNNode, contactWith radiusNode: SCNNode)
    
    //MARK: new
    func sellBuilding(on position: SCNVector3)
    func hideTowerSelectionPanel()
    func repairBuilding(on position: SCNVector3)
    func showTowerSelectionPanel(on position: SCNVector3)
    func build(_ buildingType: BuildingTypes, on position: SCNVector3)
    
    //MARK: bad code
    func fixCurrentPosition()
    func dragCamera(by position: SCNVector3)
    
    func playGame()
    func stopGame()
}
