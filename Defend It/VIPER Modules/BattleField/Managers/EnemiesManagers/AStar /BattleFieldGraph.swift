//
//  BattleFieldGraph.swift
//  Defend It
//
//  Created by MacBook Pro on 21.03.22.
//

import Foundation

struct BattleFieldGraph: Graph {
    
    var battleField: [[Vertex]] = []
    var size: Int
    
    init(size: Int) {
        for x in 0..<size {
            var row: [Vertex] = []
            for y in 0..<size {
                row.append(Vertex(x: x, y: y))
            }
            battleField.append(row)
        }
        self.size = size
    }
    
    struct Vertex: Hashable {
        var x: Int
        var y: Int
        var isWalkable: Bool = true

        static func == (lhs: Vertex, rhs: Vertex) -> Bool {
            return lhs.x == rhs.x && lhs.y == rhs.y
        }

        public var hashValue: Int {
            return x.hashValue ^ y.hashValue
        }
    }

    struct Edge: WeightedEdge {
        var cost: Double
        var target: Vertex
    }

    func edgesOutgoing(from vertex: Vertex) -> [Edge] {
        var edges: [Edge] = []
        
        let x = vertex.x
        let y = vertex.y
        let up = vertex.y - 1
        let down = vertex.y + 1
        let right = vertex.x - 1
        let left = vertex.x + 1
        
        if up >= 0 && up < size && battleField[x][up].isWalkable {
            edges.append(Edge(cost: 1, target: battleField[x][up]))
        }
        if down >= 0 && down < size && battleField[x][down].isWalkable {
            edges.append(Edge(cost: 1, target: battleField[x][down]))
        }
        if right >= 0 && right < size && battleField[right][y].isWalkable {
            edges.append(Edge(cost: 1, target: battleField[right][y]))
        }
        if left >= 0 && left < size && battleField[left][y].isWalkable {
            edges.append(Edge(cost: 1, target: battleField[left][y]))
        }
        return edges
    }
    
    mutating func makeBarrierAt(x: Int, y: Int) {
        battleField[x][y].isWalkable = false
    }
}
