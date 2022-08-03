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
    var isAvailable: Bool = false
    var id: Int = 0
    
    init(imageNamed: String, id: Int) {
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.id = id
        addLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addLabel() {
        let idLabel = SKLabelNode(text: "\(id)")
        idLabel.fontColor = .brown
        idLabel.fontSize = 110
        idLabel.fontName = "AvenirNext-Bold"
        idLabel.position = CGPoint(x: -4, y: -150)
        idLabel.zPosition = 1
        
        self.addChild(idLabel)
    }
    
}

// funcs and vars for handle user interactions
extension BattleMapIcon {
    
    override var isUserInteractionEnabled: Bool {
        set {}
        get {return true}
    }
        
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isAvailable {return}
        delegate.battleIconPressed(byId: id)
    }
}
