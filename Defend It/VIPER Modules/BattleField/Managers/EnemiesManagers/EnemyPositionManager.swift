//
//  EnemyPathManager.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

protocol EnemyPositionManager {
    
    func culculateStartPosition() -> SCNVector3
    func run(_ enemy: Enemy)
    func runByNewPath(_ enemy: Enemy)
    func prohibitWalking(On coordination: (Int, Int))
    func allowWalking(On coordination: (Int, Int))
}

class EnemyPositionManagerImpl: EnemyPositionManager {
    var battleFieldSize: Int!
    private var graph: BattleFieldGraph!
    private let start: (Int, Int) = (3, 0)
    private let target: (Int, Int) = (3, 6)
    private var enemyRunQueue = OperationQueue()
    private var sendOperation : RunEnemyOperation!
    
    init(_ battleFieldSize: Int) {
        self.battleFieldSize = battleFieldSize
        createBattleFieldGraph()
    }
    
    func culculateStartPosition() -> SCNVector3 {
        SCNVector3(-0.25 + CGFloat(battleFieldSize)/4, 0, -0.25)
    }
    
    // need func -start-
    private func runOneSquare(_ enemy: Enemy, to location: SCNVector3) {
        enemy.enemyNode.removeAllActions()
        let time = Converter.toSecond(from: enemy.speed)
        let action = SCNAction.move(to: location, duration: time)
        enemy.enemyNode.runAction(action)
    }
    
    func run(_ enemy: Enemy) {
        sendOperation = RunEnemyOperation(enemy, by: calculatePath(for: enemy), for: runOneSquare)
        enemyRunQueue.addOperation(sendOperation)
    }
    
    func runByNewPath(_ enemy: Enemy) {
        if sendOperation != nil {
            sendOperation.cancel()
            enemy.enemyNode.removeAllActions()
            run(enemy)
        }
    }
    
    private func calculatePath(for enemy: Enemy) -> [SCNVector3] {
        var coordinate = Converter.toCoordinate(from: enemy.enemyNode.position)
        if coordinate.0 < 0 || coordinate.1 < 0 {
            coordinate = start
        }
        let aStarGraph = AStar(graph: graph, heuristic: manhattanDistance)
        let start = BattleFieldGraph.Vertex(x: coordinate.0, y: coordinate.1)
        let target = BattleFieldGraph.Vertex(x: target.0, y: target.1)
        let path = aStarGraph.path(start: start, target: target).dropFirst().map{($0.x, $0.y)}
        return Converter.toPositions(from: path)
    }
    
    private func createBattleFieldGraph() {
        graph = BattleFieldGraph(size: battleFieldSize)
    }
    
    func prohibitWalking(On coordination: (Int, Int)) {
        graph.battleField[coordination.0][coordination.1].isWalkable = false
    }
    
    func allowWalking(On coordination: (Int, Int)) {
        graph.battleField[coordination.0][coordination.1].isWalkable = true
    }
    
    private func manhattanDistance(_ s: BattleFieldGraph.Vertex, _ t: BattleFieldGraph.Vertex) -> Double {
        return Double(abs(s.x - t.x) + abs(s.y - t.y))
    }
}

