//
//  EnemyRunOperation.swift
//  Defend It
//
//  Created by MacBook Pro on 23.03.22.
//

import Foundation
import SceneKit

class EnemyRunOperation: Operation {
    
    var path: [SCNVector3]
    var runOneSquare: (SCNVector3)->()
    
    init(by path: [SCNVector3], runOneSquare: @escaping (SCNVector3)->()) {
        self.path = path
        self.runOneSquare = runOneSquare
    }
    
    override func main() {
        run(by: path, runOneSquare: runOneSquare)
    }
    
    func run(by path: [SCNVector3], runOneSquare: @escaping (SCNVector3)->()) {
        for (i, location) in path.enumerated() {
            DispatchQueue.main.async {
                print("\(i). \(location)")
                runOneSquare(location)
            }
            sleep(1)
        }
    }
    
}
