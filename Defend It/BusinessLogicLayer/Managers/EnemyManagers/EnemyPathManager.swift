//
//  EnemyPathManager.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

class EnemyPathManager {
    
    static let shared = EnemyPathManager()
    
    private var graph: BattleFieldGraph!
    private var start: (Int, Int)!
    private var target: (Int, Int)!
    
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
        return Converter.toPositions(from: path)
    }
    
    func setStart(coordinate: (Int, Int)) {
        start = coordinate
    }
    
    func setTarget(coordinate: (Int, Int)) {
        target = coordinate
    }
    
    func createBattleFieldGraph(size: Int) {
        graph = BattleFieldGraph(size: size)
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

