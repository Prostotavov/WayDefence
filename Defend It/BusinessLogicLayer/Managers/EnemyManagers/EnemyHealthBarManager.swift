//
//  EnemyHealthBarManager.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.08.22.
//

import SceneKit

class EnemyHealthBarManager {
    static func addHealthProgressBar(for enemy: AnyEnemy) {
        if enemy.currentHealthPoints == enemy.healthPoints {return}
        let progressBar = SCNProgressBar(width: 0.3, height: 0.05)
        progressBar.progressTintColor = .red
        progressBar.progress = enemy.currentHealthPoints / enemy.healthPoints
        let enemyHeight = enemy.enemyNode.boundingBox.max.y * 0.5
        progressBar.position = SCNVector3(0, enemyHeight + 0.1 , 0)
        enemy.enemyNode.addChildNode(progressBar)
    }
    
    static func updateHealthProgressBar(for enemy: AnyEnemy) {
        let progressBar = enemy.enemyNode.childNode(withName: NodeNames.progressBar.rawValue, recursively: true)
        progressBar?.removeFromParentNode()
        addHealthProgressBar(for: enemy)
    }
}
