//
//  EnemyRunOperation.swift
//  Defend It
//
//  Created by MacBook Pro on 23.03.22.
//

import Foundation
import SceneKit

class RunEnemyOperation: Operation {
    
    var enemy: Enemy
    var path: [SCNVector3]
    var completion: (Enemy, SCNVector3)->()
    
    init(_ enemy: Enemy, by path: [SCNVector3], for completion: @escaping (Enemy, SCNVector3)->()) {
        self.enemy = enemy
        self.path = path
        self.completion = completion
    }
    
    override func main() {
        run(enemy, by: path, for: completion)
    }
    
    func run(_ enemy: Enemy, by path: [SCNVector3], for completion: @escaping (Enemy, SCNVector3)->()) {
        for (i, location) in path.enumerated() {
            if self.isCancelled{
                break
            }
            DispatchQueue.main.async {
                print("\(i). \(location)")
                completion(enemy, location)
            }
            usleep(Converter.toUsecond(from: enemy.speed))
        }
    }
    
}
