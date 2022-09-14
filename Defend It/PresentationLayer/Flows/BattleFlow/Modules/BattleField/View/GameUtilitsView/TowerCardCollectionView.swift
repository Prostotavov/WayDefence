//
//  TowerCardCollectionView.swift
//  Defend It
//
//  Created by Роман Сенкевич on 12.09.22.
//

import UIKit

class TowerCardCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    let collectionViewHeight: CGFloat = 200
    let collectionViewWidth: CGFloat = 300
    var collectionView: UICollectionView?
    
    var buildingCards: [BuildingCard] = []
    
    func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {return}
        collectionView.register(TowerCardCell.self, forCellWithReuseIdentifier: TowerCardCell.identifier)
        layout.collectionView?.delaysContentTouches = false
        
        
        
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            collectionView.heightAnchor.constraint(equalTo: self.heightAnchor),
            collectionView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buildingCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TowerCardCell.identifier, for: indexPath) as! TowerCardCell
        cell.configure(buildingCards[indexPath.row])
        return cell
    }
}

extension TowerCardCollectionView: UIGestureRecognizerDelegate {
    
    func cellForItem(at location: CGPoint) -> TowerCardCell? {
        guard let collectionView = collectionView else {return nil}
        guard let targetIndexPath = collectionView.indexPathForItem(at: location) else {return nil}
        guard let cell = collectionView.cellForItem(at: targetIndexPath) as? TowerCardCell else {return nil}
        return cell
    }
    
    func displayBuildingCards(_ buildingCards: [BuildingCard]) {
        self.buildingCards = buildingCards
    }

}

