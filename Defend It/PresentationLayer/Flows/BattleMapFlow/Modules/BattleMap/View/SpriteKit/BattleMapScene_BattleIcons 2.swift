//
//  BattleMapScene_BattleIcons.swift
//  Defend It
//
//  Created by Роман Сенкевич on 29.07.22.
//

import SpriteKit

extension BattleMapScene: BattleMapIconDelegate {
    
    func battleIconPressed(byId id: Int) {
        output.battleIconPressed(byId: id)
    }
    
    func setupBattleIcons() {
        
        for i in 0...4 {
            let battleIcon = BattleMapIcon(imageNamed: "button1")
            battleIcon.delegate = self
            battleIcon.id = i
            battleIcon.xScale = 0.3
            battleIcon.yScale = 0.3
            battleIcon.position = CGPoint(x: size.width / 2 + 190 * CGFloat(i) - 300, y: size.height / 2 + 190 * CGFloat(i) - 300)
            battleIcon.zPosition = 1
            addChild(battleIcon)
        }
    }
}
