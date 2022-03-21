//
//  Fence.swift
//  Defend It
//
//  Created by MacBook Pro on 19.03.22.
//

import Foundation
import SceneKit

protocol Fence {
    func createFence(size: Int) -> [FenceCell]
}

struct FenceImpl: Fence {
    func createFence(size: Int) -> [FenceCell] {
        var fence: [FenceCell] = []
        
        for i in 0..<size {
            let fenceCell = FenceCellImpl()
            fenceCell.scnFenceCellNode.position = SCNVector3(CGFloat(i)/2, 0, 3.25)
            fenceCell.scnFenceCellNode.eulerAngles = SCNVector3(0, 3.14/2, 0)
            fence.append(fenceCell)
        }
        for i in 0..<size {
            let fenceCell = FenceCellImpl()
            fenceCell.scnFenceCellNode.position = SCNVector3(CGFloat(i)/2, 0, -0.25)
            fenceCell.scnFenceCellNode.eulerAngles = SCNVector3(0, 3.14/2, 0)
            fence.append(fenceCell)
        }
        for i in 0..<size {
            if ( i == Int(size/2)) { continue }
            let fenceCell = FenceCellImpl()
            fenceCell.scnFenceCellNode.position = SCNVector3(3.25, 0, CGFloat(i)/2)
            fence.append(fenceCell)
        }
        for i in 0..<size {
            if ( i == Int(size/2)) { continue }
            let fenceCell = FenceCellImpl()
            fenceCell.scnFenceCellNode.position = SCNVector3(-0.25, 0, CGFloat(i)/2)
            fence.append(fenceCell)
        }
        return fence
    }
}


protocol FenceCell {
    var scnFenceCellNode: SCNNode {get set}
}

struct FenceCellImpl: FenceCell {
    var scene: SCNScene
    var scnFenceCellNode: SCNNode
    
    init() {
        scene = SCNScene(named: "art.scnassets/allElements.scn")!
        scnFenceCellNode = scene.rootNode.childNode(withName: "fence", recursively: true)!
    }
}
