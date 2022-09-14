//
//  TowersPanelView.swift
//  Defend It
//
//  Created by Роман Сенкевич on 12.09.22.
//

import UIKit

class TowersPanelView: UIView {
    
    let towerCardCollectionView = TowerCardCollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setCollectionView() {
        self.addSubview(towerCardCollectionView)
        
        towerCardCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            towerCardCollectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            towerCardCollectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            towerCardCollectionView.heightAnchor.constraint(equalTo: self.heightAnchor),
            towerCardCollectionView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    func cellForItem(at location: CGPoint) -> TowerCardCell? {
        towerCardCollectionView.cellForItem(at: location)
    }
    
    func displayBuildingCards(_ buildingCards: [BuildingCard]) {
        towerCardCollectionView.displayBuildingCards(buildingCards)
    }
    
}

