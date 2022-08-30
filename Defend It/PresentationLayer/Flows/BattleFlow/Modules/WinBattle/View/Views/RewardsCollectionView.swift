//
//  RewardsCollectionView.swift
//  Defend It
//
//  Created by Роман Сенкевич on 29.08.22.
//

import UIKit

class RewardsCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let collectionViewHeight: CGFloat = 200
    let collectionViewWidth: CGFloat = 300
    var collectionView: UICollectionView?
    
    var valuesReward: EconomicAccountValues!
    var itemsReward: [(item: Equipment, quantity: Int)] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionView()
        
        let id = CurrentBattleImp.shared.chosenBattleMission
        valuesReward = BattleMissionsRewardData.shared.getRewardForBattle(id: id).economicAccountVlues
        itemsReward = BattleMissionsRewardData.shared.getRewardForBattle(id: id).equipments

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (collectionViewWidth / 5) - 1,
                                 height: (collectionViewWidth / 5) - 1)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {return}
        collectionView.register(EquipmentCellImp.self, forCellWithReuseIdentifier: EquipmentCellImp.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7, right: 7.0)
        
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 100),
            collectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight),
            collectionView.widthAnchor.constraint(equalToConstant: collectionViewWidth)
        ])
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemsReward.count + 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EquipmentCellImp.identifier, for: indexPath) as! EquipmentCell
        
        // display money
        if indexPath.row == 0 {
            cell.configure(image: .money, text: String(valuesReward.get(.coins)))
            return cell
        }
        
        // display gems
        if indexPath.row == 1 {
            cell.configure(image: .diamond, text: String(valuesReward.get(.gems)))
            return cell
        }
        
        // display points
        if indexPath.row == 2 {
            cell.configure(image: .flask, text: String(valuesReward.get(.points)))
            return cell
        }
        
        // display equipments
        let imageName = itemsReward[indexPath.row - 3].0.imageName
        let text = String(itemsReward[indexPath.row - 3].1)
        
        cell.configure(image: imageName, text: text)
        return cell
    }
}
