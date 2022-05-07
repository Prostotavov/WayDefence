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
    func pressed(_ node: SCNNode)
    func deviceOrientationChanged(to orientation: UIDeviceOrientation)
    func newFrameDidRender()
    func didBegin(_ enemyNode: SCNNode, contactWith radiusNode: SCNNode)
    func didEnd(_ enemyNode: SCNNode, contactWith radiusNode: SCNNode)
}
