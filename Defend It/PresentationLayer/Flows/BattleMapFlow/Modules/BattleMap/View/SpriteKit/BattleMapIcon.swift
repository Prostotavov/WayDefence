//
//  BattleMapIcon.swift
//  Defend It
//
//  Created by Роман Сенкевич on 29.07.22.
//

import SpriteKit

protocol BattleMapIconDelegate: AnyObject {
    func battleIconPressed(byId id: Int)
}

class BattleMapIcon: SKSpriteNode {
    
    weak var delegate: BattleMapIconDelegate!
    
    override var isUserInteractionEnabled: Bool {
        set {}
        get {return true}
    }
    var id: Int = 0
        
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate.battleIconPressed(byId: id)
    }
    
}


