//
//  EnemyAnimationManager.swift
//  Defend It
//
//  Created by Роман Сенкевич on 18.08.22.
//

import SceneKit

struct EnemyAnimationManager {

    static func addAnimation(for enemy: AnyEnemy) {
        
        if enemy.race == .goblin && enemy.level == .firstLevel {} else {return}
        
        // animation path
        let path = "art.scnassets/enemies/goblins/goblinFLAnimation.scn"
        
        //setup animation
        let scnAnimation = SCNAnimation(named: path)
        scnAnimation.usesSceneTimeBase = false
        scnAnimation.repeatCount = .infinity
                
        // setup animation Player
        let animationPlayer = SCNAnimationPlayer(animation: scnAnimation)
        enemy.enemyNode.addAnimationPlayer(animationPlayer, forKey: "walkPlayer")
        
        // run animation player
        animationPlayer.play()
    }
    
    static func resumeAnimation(for enemy: AnyEnemy) {
        enemy.enemyNode.animationPlayer(forKey: "walkPlayer")?.speed = 1
    }
    
    static func stopAnimation(for enemy: AnyEnemy) {
        enemy.enemyNode.animationPlayer(forKey: "walkPlayer")?.speed = 0

    }
}
