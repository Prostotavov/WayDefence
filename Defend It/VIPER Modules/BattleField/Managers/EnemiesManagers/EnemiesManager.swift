//
//  EnemiesManager.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import SceneKit

protocol EnemiesManager {
    var enemy: Enemy {get set}
    func run()
    func prohibitWalking(On coordination: (Int, Int))
    func allowWalking(On coordination: (Int, Int))
}

class EnemiesManagerImpl: EnemiesManager, EnemyDelegate {
    var battleFieldSize: Int!
    var graph: BattleFieldGraph!
    var enemy: Enemy = EnemyImpl()
    
    init(_ battleFieldSize: Int) {
        self.battleFieldSize = battleFieldSize
        enemy.scnEnemyNode.position = calculateStartPosition()
        createBattleFieldGraph()
        enemy.delegate = self
    }
    
    func calculateStartPosition() -> SCNVector3 {
        SCNVector3(-0.25 + CGFloat(battleFieldSize)/4, 0, -0.25)
    }
    
    func run() {
        enemy.run(by: Converter.toPositions(From: calculatePath()))
    }
    
    func manhattanDistance(_ s: BattleFieldGraph.Vertex, _ t: BattleFieldGraph.Vertex) -> Double {
        return Double(abs(s.x - t.x) + abs(s.y - t.y))
    }
    
    func createBattleFieldGraph() {
        graph = BattleFieldGraph(size: battleFieldSize)
    }
    
    func prohibitWalking(On coordination: (Int, Int)) {
        graph.battleField[coordination.0][coordination.1].isWalkable = false
    }
    
    func allowWalking(On coordination: (Int, Int)) {
        graph.battleField[coordination.0][coordination.1].isWalkable = true
    }
    
    
    
    func calculatePath() -> [(Int, Int)] {
        enemy.coordinate = Converter.toCoordination(From: enemy.scnEnemyNode.position)
        if enemy.coordinate.0 < 0 || enemy.coordinate.1 < 0 {
            enemy.coordinate = (3, 0)
        }
        let aStarGraph = AStar(graph: graph, heuristic: manhattanDistance)
        let start = BattleFieldGraph.Vertex(x: enemy.coordinate.0, y: enemy.coordinate.1)
        let target = BattleFieldGraph.Vertex(x: 3, y: 6)
        let path = aStarGraph.path(start: start, target: target).dropFirst().map{($0.x, $0.y)}
        return path
    }
}
