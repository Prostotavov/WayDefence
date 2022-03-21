//
//  EnemyPathManager.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import Foundation
import SceneKit

protocol EnemyPathManager {
    func calculatePathAStar(ground: [[GroundCell]]) -> [(Int, Int)]
}

class EnemyPathManagerImpl: EnemyPathManager {
    
    var graph: BattleFieldGraph!
    
    func manhattanDistance(_ s: BattleFieldGraph.Vertex, _ t: BattleFieldGraph.Vertex) -> Double {
        return Double(abs(s.x - t.x) + abs(s.y - t.y))
    }
    
    func createBattleFieldGraph(ground: [[GroundCell]]) {
        graph = BattleFieldGraph(size: ground.count / 2)
        for (x, row) in ground.enumerated() {
            for (z, cell) in row.enumerated() {
                if cell.scnBuildingNode != nil {
                    graph.battleField[x][z].isWalkable = false
                }
            }
        }
    }
    
    func calculatePathAStar(ground: [[GroundCell]]) -> [(Int, Int)] {
        createBattleFieldGraph(ground: ground)
        let aStarGraph = AStar(graph: graph, heuristic: manhattanDistance)
        let start = BattleFieldGraph.Vertex(x: 3, y: 0)
        let target = BattleFieldGraph.Vertex(x: 3, y: 6)
        return aStarGraph.path(start: start, target: target).map{($0.x, $0.y)}
    }
}
