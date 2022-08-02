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
    func playButtonPressed()
    func stopButtonPressed()
    func onPauseTap()
    
    /// handle pressed node
    func pressedNode(_ node: SCNNode)
    
    func doubleTapOccurred()
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    func panGestureOccurred(recognizer: UIPanGestureRecognizer, view: inout UIView)
    func pinchGestureOccurred(recognizer: UIPinchGestureRecognizer, view: inout UIView)
}
