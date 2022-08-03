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
        
        for i in 1...BattleMissions.allCases.count {
            // init lock or available battleIcon
            var battleIcon:  BattleMapIcon!
            var lastAvailableId: Int!
            
            /// crutch error correction. When all the missions are completed, then lastAvailableMission = nil
            if  ((CurrentBattleImp.shared.lastAvailableMission?.rawValue) != nil) {
                lastAvailableId = CurrentBattleImp.shared.lastAvailableMission!.rawValue
            } else {
                lastAvailableId = i + 1
            }
            
            /// initialize the button depending on which battles over are available
            if lastAvailableId == i {
                battleIcon = BattleMapIcon(imageNamed: "availableBattle", id: i)
                battleIcon.isAvailable = true
            } else if lastAvailableId < i {
                battleIcon = BattleMapIcon(imageNamed: "lockBattle", id: i)
                battleIcon.isAvailable = false
            } else {
                battleIcon = BattleMapIcon(imageNamed: "passedBattle", id: i)
                battleIcon.isAvailable = true
            }
            
            // set delegate
            battleIcon.delegate = self
            
            // set size for battleIcon
            let width: CGFloat = 130
            let height: CGFloat = 130 / battleIcon.size.width *  battleIcon.size.height
            battleIcon.size = CGSize(width: width, height: height)
            
            // set position for battleIcon
            battleIcon.position = CGPoint(x: size.width / 2 + 190 * CGFloat(i) - 300, y: size.height / 2)
            battleIcon.zPosition = 1
            
            // add battle icon to the scene
            addChild(battleIcon)
        }
    }
}
