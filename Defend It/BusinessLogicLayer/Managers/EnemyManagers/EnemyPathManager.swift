//
//  EnemyPathManager.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit
import GameplayKit
import SpriteKit

class EnemyPathManager {
    
    static let shared = EnemyPathManager()
    private var obstacleGraph: GKObstacleGraph<GKGraphNode2D>!
    
    private var start: (Int, Int)!
    private var target: (Int, Int)!
    
    func culculateStartPosition() -> SCNVector3 {
        Converter.toPosition(from: start)
    }
    
    
    func calculatePath<T: Enemy>(for enemy: T) -> [SCNVector3] {

        /// create and setup start and target nodes -start-
        let startPosition: vector_float2 = vector_float2(x: enemy.enemyNode.position.x, y: enemy.enemyNode.position.z)
        let targetPosition = vector_float2(x: Float(target.0) * 0.5 ,y: Float(target.1) * 0.5)
        
        let startNode = GKGraphNode2D(point: startPosition)
        let targetNode = GKGraphNode2D(point: targetPosition)
        obstacleGraph.connectUsingObstacles(node: startNode)
        obstacleGraph.connectUsingObstacles(node: targetNode)
        /// create and setup start and target nodes -end-
        
        /// calculate path
        let pathNodes = obstacleGraph.findPath(from: startNode, to: targetNode) as! [GKGraphNode2D]

        /// remove start  and target nodes
        obstacleGraph.remove([startNode, targetNode])
        
        /// convert to output
        let pathPoints: [SCNVector3] = pathNodes.map { SCNVector3(x: $0.position.x, y: 0, z: $0.position.y) }
        return pathPoints
    }
    
    func setStart(coordinate: (Int, Int)) {
        start = coordinate
    }
    
    func setTarget(coordinate: (Int, Int)) {
        target = coordinate
    }
    
    /// done
    func createBattleFieldGraph(size: Int) {
        /// if size = 1, then height = 0.5
        let borderLength = CGFloat(size) * 0.5
        let sprite0 = SKSpriteNode(color: .red, size: CGSize(width: 0.1, height: borderLength))       // up
        let sprite1 = SKSpriteNode(color: .red, size: CGSize(width: 0.1, height: borderLength))       // up
        let sprite2 = SKSpriteNode(color: .red, size: CGSize(width: borderLength, height: 0.1))       // right
        let sprite3 = SKSpriteNode(color: .red, size: CGSize(width: borderLength, height: 0.1))       // right
        
        sprite0.anchorPoint = CGPoint(x: 0, y: 0)       // up
        sprite1.anchorPoint = CGPoint(x: 0, y: 0)       // up
        sprite2.anchorPoint = CGPoint(x: 0, y: 0)       // right
        sprite3.anchorPoint = CGPoint(x: 0, y: 0)       // right

        sprite0.position = CGPoint(x: 0, y: 0)                  // up
        sprite1.position = CGPoint(x: borderLength, y: 0)       // up
        sprite2.position = CGPoint(x: 0, y: 0)                  // right
        sprite3.position = CGPoint(x: 0, y: borderLength)       // right
        
        /// create and setup graph -start-
        let obstacleSpriteNodes: [SKSpriteNode] = [sprite0, sprite1, sprite2, sprite3]
        let polygonObstacles: [GKPolygonObstacle] = SKNode.obstacles(fromNodeBounds: obstacleSpriteNodes)
        obstacleGraph = GKObstacleGraph(obstacles: polygonObstacles, bufferRadius: 0.15)
        /// create and setup graph -end-
    }
    
    func prohibitWalking(On coordination: (Int, Int)) {
        let obstacleSprite = SKSpriteNode(color: .red, size: CGSize(width: 0.5, height: 0.5))
        obstacleSprite.name = "\(coordination)"
        obstacleSprite.position = CGPoint(x: CGFloat(coordination.0) * 0.5, y: CGFloat(coordination.1) * 0.5)
        let obstaclePolygon = SKNode.obstacles(fromNodeBounds: [obstacleSprite])
        obstacleGraph.addObstacles(obstaclePolygon)
    }
    
    func allowWalking(On coordination: (Int, Int)) {
        // drop first 4 because first 4 obstacles is the border og battleField
        for obstacle in obstacleGraph.obstacles.dropFirst(4) {
            if obstacle.centerCoordinate == coordination {
                obstacleGraph.removeObstacles([obstacle])
            }
        }
    }
}



extension GKPolygonObstacle {
    
    var centerPosition: CGPoint {
        var x: CGFloat = 0
        var y: CGFloat = 0
        for i in 0...3 {
            x += CGFloat(self.vertex(at: i).x)
            y += CGFloat(self.vertex(at: i).y)
        }
        x *= 0.25
        y *= 0.25
        
        return CGPoint(x: x, y: y)
    }
    
    var centerCoordinate: (Int, Int) {
        var x: CGFloat = 0
        var y: CGFloat = 0
        for i in 0...3 {
            x += CGFloat(self.vertex(at: i).x)
            y += CGFloat(self.vertex(at: i).y)
        }
        x *= 0.5
        y *= 0.5
        
        return (Int(round(x)), Int(round(y)))
    }
}
