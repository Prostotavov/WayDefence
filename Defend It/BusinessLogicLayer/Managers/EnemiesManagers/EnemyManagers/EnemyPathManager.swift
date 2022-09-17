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
        return findPathInObtacleGraph(for: enemy)
    }
    
    func setStart(coordinate: (Int, Int)) {
        start = coordinate
    }
    
    func setTarget(coordinate: (Int, Int)) {
        target = coordinate
    }
    
    func createBattleFieldGraph(size: Int) {
        createObstacleGraph(size: size)
    }
    
    func prohibitWalking(on coordinate: (Int, Int), byBuildingWith size: (Int, Int)) {
        prohibitWalkingInObstacleGraph(on: coordinate, byBuildingWith: size)
    }
    
    func allowWalking(on coordinate: (Int, Int), byBuildingWith size: (Int, Int)) {
        allowWalkingInObstacleGraph(on: coordinate, byBuildingWith: size)
    }
}

/// obstacle graph
extension EnemyPathManager {
    
    func findPathInObtacleGraph<T: Enemy>(for enemy: T) -> [SCNVector3] {
        /// create and setup start and target nodes -start-
        let startPosition = vector_float2(x: enemy.enemyNode.position.x, y: enemy.enemyNode.position.z)
        let gameUnit = Float(GameConstants.goundSquareSize)
        let targetPosition = vector_float2(x: Float(target.0) * gameUnit ,y: Float(target.1) * gameUnit)
        
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
    
    func createObstacleGraph(size: Int) {
        
        let gameUnit = GameConstants.goundSquareSize
        let borderLength = CGFloat(size) * gameUnit + gameUnit * 2
        /// spites 0-3 create a border of the battlefield
        let sprite0 = SKSpriteNode(color: .red, size: CGSize(width: 0.05, height: borderLength))       // up
        let sprite1 = SKSpriteNode(color: .red, size: CGSize(width: 0.05, height: borderLength))       // up
        let sprite2 = SKSpriteNode(color: .red, size: CGSize(width: borderLength, height: 0.05))       // right
        let sprite3 = SKSpriteNode(color: .red, size: CGSize(width: borderLength, height: 0.05))       // right
        
        sprite0.anchorPoint = CGPoint(x: 0, y: 0)       // up
        sprite1.anchorPoint = CGPoint(x: 0, y: 0)       // up
        sprite2.anchorPoint = CGPoint(x: 0, y: 0)       // right
        sprite3.anchorPoint = CGPoint(x: 0, y: 0)       // right

        sprite0.position = CGPoint(x: -gameUnit, y: -gameUnit)                         // up
        sprite1.position = CGPoint(x: borderLength - gameUnit * 2, y: -gameUnit)       // up
        sprite2.position = CGPoint(x: -gameUnit, y: -gameUnit)                         // right
        sprite3.position = CGPoint(x: -gameUnit, y: borderLength - gameUnit * 2)       // right
        
        /// create and setup graph -start-
        let obstacleSpriteNodes: [SKSpriteNode] = [sprite0, sprite1, sprite2, sprite3]
        let polygonObstacles: [GKPolygonObstacle] = SKNode.obstacles(fromNodeBounds: obstacleSpriteNodes)
        obstacleGraph = GKObstacleGraph(obstacles: polygonObstacles, bufferRadius: 0.05)
        /// create and setup graph -end-
    }
    
    func allowWalkingInObstacleGraph(on coordinate: (Int, Int), byBuildingWith size: (Int, Int)) {
        // drop first 4 because first 4 obstacles is the border of battleField
        for obstacle in obstacleGraph.obstacles.dropFirst(4) {
            if obstacle.isAnchorCoordinate(a: coordinate, size: size) {
                obstacleGraph.removeObstacles([obstacle])
            }
        }
    }
    
    func prohibitWalkingInObstacleGraph(on coordinate: (Int, Int), byBuildingWith size: (Int, Int)) {
        let gameUnit = GameConstants.goundSquareSize
        /// size
        let width = gameUnit * CGFloat(size.0)
        let height = gameUnit * CGFloat(size.1)
        /// position
        let x = CGFloat(coordinate.0) * gameUnit
        let y = CGFloat(coordinate.1) * gameUnit
        /// anchor    0.5 is not a gameUnit
        let xAnchor = (CGFloat(size.0) - 0.5) / CGFloat(size.0)
        let yAnchor = (CGFloat(size.0) - 0.5) / CGFloat(size.0)
        /// create obstacle
        let obstacleSprite = SKSpriteNode(color: .red, size: CGSize(width: width, height: height))
        obstacleSprite.anchorPoint = CGPoint(x: xAnchor, y: yAnchor)
        obstacleSprite.position = CGPoint(x: x, y: y)
        let obstaclePolygon = SKNode.obstacles(fromNodeBounds: [obstacleSprite])
        obstacleGraph.addObstacles(obstaclePolygon)
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
        /// divide by 4 to find the arithmetic mean between the 4 sides
        x /= 4
        y /= 4
        return CGPoint(x: x, y: y)
    }
    
    func isAnchorCoordinate(a coordinate: (Int, Int), size: (Int, Int)) -> Bool {
        let gameUnit = GameConstants.goundSquareSize
        /// offset from center of the sprite
        let widthOffset = CGFloat(size.0 - 1) / 2.0 * gameUnit
        let heightOffset = CGFloat(size.1 - 1) / 2.0 * gameUnit
        
        let xAnchorPosition = centerPosition.x + widthOffset
        let yAnchorPosition = centerPosition.y + heightOffset
        
        let xAnchorCoordinate = Int(round(xAnchorPosition / gameUnit))
        let yAnchorCoordinate = Int(round(yAnchorPosition / gameUnit))
        
        if coordinate.0 == xAnchorCoordinate && coordinate.1 == yAnchorCoordinate {return true}
        return false
    }
    
}




//       +z(y) ____________________________
//            |          sprite3           |
//            |                            |
//            |s                (1,1)      |s
//            |p              ↓ achor      |p
//            |r         xxxxxx←           |r
//            |i         xxxxxx            |i
//            |t         xxxxxx            |t
//            |e                           |e
//            |0                           |1
//            |                            |
//            |____________________________|
//           0           sprite2          +x
