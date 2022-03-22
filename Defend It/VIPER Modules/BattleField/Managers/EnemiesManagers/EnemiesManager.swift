//
//  EnemiesManager.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import SceneKit

protocol EnemiesManager {
    var enemy: Enemy {get set}
    mutating func run()
    mutating func prohibitWalking(On coordination: (Int, Int))
    mutating func allowWalking(On coordination: (Int, Int))
}

struct EnemiesManagerImpl: EnemiesManager {
    var battleFieldSize: Int!
    var graph: BattleFieldGraph!
    var enemy: Enemy = EnemyImpl()
    
    init(_ battleFieldSize: Int) {
        self.battleFieldSize = battleFieldSize
        enemy.scnEnemyNode.position = calculateStartPosition()
        createBattleFieldGraph()
    }
    
    func calculateStartPosition() -> SCNVector3 {
        SCNVector3(-0.25 + CGFloat(battleFieldSize)/4, 0, -0.75)
    }
    
    mutating func run() {
        enemy.run(by: Converter.toPositions(From: calculatePath()))
    }
    
    func manhattanDistance(_ s: BattleFieldGraph.Vertex, _ t: BattleFieldGraph.Vertex) -> Double {
        return Double(abs(s.x - t.x) + abs(s.y - t.y))
    }
    
    mutating func createBattleFieldGraph() {
        graph = BattleFieldGraph(size: battleFieldSize)
    }
    
    mutating func prohibitWalking(On coordination: (Int, Int)) {
        graph.battleField[coordination.0][coordination.1].isWalkable = false
    }
    
    mutating func allowWalking(On coordination: (Int, Int)) {
        graph.battleField[coordination.0][coordination.1].isWalkable = true
    }
    
    
    
    mutating func calculatePath() -> [(Int, Int)] {
        let aStarGraph = AStar(graph: graph, heuristic: manhattanDistance)
        let start = BattleFieldGraph.Vertex(x: enemy.coordinate.0, y: enemy.coordinate.1)
        let target = BattleFieldGraph.Vertex(x: 3, y: 6)
        return aStarGraph.path(start: start, target: target).map{($0.x, $0.y)}
    }
}
