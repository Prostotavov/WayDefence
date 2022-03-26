//
//  EnemyPathManager.swift
//  Defend It
//
//  Created by MacBook Pro on 26.03.22.
//

import SceneKit

protocol EnemyPositionManager {
    
    func calculateStartPosition() -> SCNVector3
    func calculatePath(for coordiante: (Int, Int)) -> [SCNVector3]
    func allowWalking(On coordination: (Int, Int))
    func prohibitWalking(On coordination: (Int, Int))
}

class EnemyPositionManagerImpl: EnemyPositionManager {
    var battleFieldSize: Int!
    var graph: BattleFieldGraph!
    let target: (Int, Int) = (3, 6)
    
    init(_ battleFieldSize: Int) {
        self.battleFieldSize = battleFieldSize
        createBattleFieldGraph()
    }
    
    func calculateStartPosition() -> SCNVector3 {
        SCNVector3(-0.25 + CGFloat(battleFieldSize)/4, 0, -0.25)
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
    
    func manhattanDistance(_ s: BattleFieldGraph.Vertex, _ t: BattleFieldGraph.Vertex) -> Double {
        return Double(abs(s.x - t.x) + abs(s.y - t.y))
    }
    
    func calculatePath(for coordiante: (Int, Int)) -> [SCNVector3] {

        let aStarGraph = AStar(graph: graph, heuristic: manhattanDistance)
        let start = BattleFieldGraph.Vertex(x: coordiante.0, y: coordiante.1)
        let target = BattleFieldGraph.Vertex(x: target.0, y: target.1)
        let path = aStarGraph.path(start: start, target: target).dropFirst().map{($0.x, $0.y)}
        return Converter.toPositions(from: path)
    }
}
