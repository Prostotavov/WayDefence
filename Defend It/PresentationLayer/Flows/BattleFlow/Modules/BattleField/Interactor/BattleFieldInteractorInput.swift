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
    
    /// funcs for handle user taps
    func playGame()
    func stopGame()
    func speedButtonPressed()
    func pressedNode(_ node: SCNNode)
    
    /// funcs for handle nodes collisions
    func didBegin(_ nodeA: SCNNode, contactWith nodeB: SCNNode)
    func didEnd(_ nodeA: SCNNode, contactWith nodeB: SCNNode)
    func update()
    
    func doubleTapOccurred()
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    func panGestureOccurred(recognizer: UIPanGestureRecognizer, view: inout UIView)
    func pinchGestureOccurred(recognizer: UIPinchGestureRecognizer, view: inout UIView)
    
    func activateCamera()
    func inactivateCamera()
    
    // funs for building by pan a BuildingCard on BattleFieldView
    func showBuilding(_ type: BuildingTypes, with level: BuildingLevels, on position: SCNVector3)
    func pan(towerNode: SCNNode, by position: SCNVector3)
    func buildTower(with type: BuildingTypes, by coordinate: (Int, Int))
    func getBuildingCards() -> [BuildingCard]
}
