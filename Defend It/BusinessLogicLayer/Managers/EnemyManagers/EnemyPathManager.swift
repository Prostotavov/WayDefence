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
    /// done
    private var graph: BattleFieldGraph!
    private var obstacleGraph: GKObstacleGraph<GKGraphNode2D>!
    
    private var start: (Int, Int)!
    private var target: (Int, Int)!
    
    ///done
    func culculateStartPosition() -> SCNVector3 {
        Converter.toPosition(from: start)
    }
    
    
    func calculatePath<T: Enemy>(for enemy: T) -> [SCNVector3] {
        var coordinate = Converter.toCoordinate(from: enemy.enemyNode.position)
        if coordinate.0 < 0 || coordinate.1 < 0 {
            coordinate = start
        }
        let aStarGraph = AStar(graph: graph, heuristic: manhattanDistance)
        let start = BattleFieldGraph.Vertex(x: coordinate.0, y: coordinate.1)
        let target = BattleFieldGraph.Vertex(x: target.0, y: target.1)
        let path = aStarGraph.path(start: start, target: target).dropFirst().map{($0.x, $0.y)}
        
        
        
        /// create and setup start and target nodes -start-
        let startPosition: vector_float2 = vector_float2(x: enemy.enemyNode.position.x, y: enemy.enemyNode.position.z)
        let targetPosition = vector_float2(x: Float(target.x) * 0.5 ,y: Float(target.y) * 0.5)
        
        let startNode = GKGraphNode2D(point: startPosition)
        let targetNode = GKGraphNode2D(point: targetPosition)
        obstacleGraph.connectUsingObstacles(node: startNode)
        obstacleGraph.connectUsingObstacles(node: targetNode)
        /// create and setup start and target nodes -end-
        
        /// calculate path
        let pathNodes = obstacleGraph.findPath(from: startNode, to: targetNode) as! [GKGraphNode2D]

        /// setup unique radius
//        let path = GKPath(graphNodes: pathNodes, radius: 0)

        /// remove start  and target nodes
        obstacleGraph.remove([startNode, targetNode])
        
        /// convert to output
        var pathPoints: [CGPoint] = pathNodes.map {
            let x = CGFloat($0.position.x)
            let y = CGFloat($0.position.y)
            return CGPoint(x: x, y: y)
        }
        
        print("""
------------------------------------------------------------
1. \(pathPoints)
2. \(startPosition) -> \(targetNode)
""")
        
//        return pathPoints
        
        
        
        return Converter.toPositions(from: path)
    }
    
    func setStart(coordinate: (Int, Int)) {
        start = coordinate
    }
    
    func setTarget(coordinate: (Int, Int)) {
        target = coordinate
    }
    
    /// done
    func createBattleFieldGraph(size: Int) {
        graph = BattleFieldGraph(size: size)
        
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
        graph.battleField[coordination.0][coordination.1].isWalkable = false
        
        let obstacleSprite = SKSpriteNode(color: .red, size: CGSize(width: 0.5, height: 0.5))
        obstacleSprite.name = "\(coordination)"
        obstacleSprite.position = CGPoint(x: CGFloat(coordination.0) * 0.5, y: CGFloat(coordination.1) * 0.5)
        let obstaclePolygon = SKNode.obstacles(fromNodeBounds: [obstacleSprite])
        obstacleGraph.addObstacles(obstaclePolygon)
    }
    
    func allowWalking(On coordination: (Int, Int)) {
        graph.battleField[coordination.0][coordination.1].isWalkable = true
        // drop first 4 because first 4 obstacles is the border og battleField
        for obstacle in obstacleGraph.obstacles.dropFirst(4) {
            if obstacle.centerCoordinate == coordination {
                obstacleGraph.removeObstacles([obstacle])
            }
        }
    }
    
    private func manhattanDistance(_ s: BattleFieldGraph.Vertex, _ t: BattleFieldGraph.Vertex) -> Double {
        return Double(abs(s.x - t.x) + abs(s.y - t.y))
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
