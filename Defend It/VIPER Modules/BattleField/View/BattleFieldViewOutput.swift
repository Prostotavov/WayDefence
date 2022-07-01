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
    
    /// camera
    func deviceOrientationChanged(to orientation: UIDeviceOrientation)
    func panGestureChanged(by translation: CGPoint)
    func panGestureEnded()
    
    /// game state
    func playButtonPressed()
    func stopButtonPressed()
    
    /// handle pressed node
    func pressedNode(_ node: SCNNode)
}
