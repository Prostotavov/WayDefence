//
//  TowerCardCell.swift
//  Defend It
//
//  Created by Роман Сенкевич on 12.09.22.
//

import UIKit

class TowerCardCell: UICollectionViewCell {
    
    static let identifier = "TowerCardCell"
    
    var towerCardView: TowerCardView!
    var buildingCard: BuildingCard!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addEquipmentView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addEquipmentView() {
        
        let size = CGSize(width: self.frame.width, height: self.frame.height)
        let frame = CGRect(origin: .zero, size: size)
        
        towerCardView = TowerCardView(frame: frame)

        towerCardView.isUserInteractionEnabled = false
        self.addSubview(towerCardView)
        towerCardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            towerCardView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            towerCardView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            towerCardView.heightAnchor.constraint(equalTo: self.heightAnchor),
            towerCardView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    func configure(_ buildingCard: BuildingCard) {
        self.buildingCard = buildingCard
        guard let imageName = buildingCard.info.upgradeSelection.first?.rawValue else {return}
        let text = String(buildingCard.parameter.buildingCost)
        towerCardView.configure(image: imageName, text: text)
    }
}


