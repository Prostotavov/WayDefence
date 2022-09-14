// 
//  BattleFieldViewOutput.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation
import SceneKit

protocol BattleFieldViewOutput: AnyObject {
    
    func loadView()
    func viewDidAppear()

    /// handle nodes collision
    func didBegin(_ nodeA: SCNNode, contactWith nodeB: SCNNode)
    func didEnd(_ nodeA: SCNNode, contactWith nodeB: SCNNode)
    
    /// this func called every new frame and update game
    func update()
        
    /// game state
    func speedButtonPressed()
    func onPauseTap()

    
    /// handle pressed node
    func pressedNode(_ node: SCNNode)
    
    func doubleTapOccurred()
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    func panGestureOccurred(recognizer: UIPanGestureRecognizer, view: inout UIView)
    func pinchGestureOccurred(recognizer: UIPinchGestureRecognizer, view: inout UIView)
    
    //MARK: camera
    func activateCamera()
    func inactivateCamera()
    
    //MARK: building by pan a BuildingCard
    func showBuilding(_ type: BuildingTypes, with level: BuildingLevels, on position: SCNVector3)
    func pan(towerNode: SCNNode, by potision: SCNVector3)
    func buildTower(with type: BuildingTypes, by coordinate: (Int, Int))
}
