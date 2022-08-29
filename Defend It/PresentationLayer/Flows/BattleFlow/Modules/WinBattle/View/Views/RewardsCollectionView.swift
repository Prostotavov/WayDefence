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
    
    let testArrayOfRewardItems: [(ImageNames, String)] = [
        (ImageNames.blade, "1"), (ImageNames.arch, "2"), (ImageNames.hammer, "1"),
        (ImageNames.diamond, "10"), (ImageNames.money, "175"), (ImageNames.flask, "7")
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionView()

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
        testArrayOfRewardItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EquipmentCellImp.identifier, for: indexPath) as! EquipmentCell
        
        let imageName = testArrayOfRewardItems[indexPath.row].0
        let text = testArrayOfRewardItems[indexPath.row].1
        
        cell.configure(image: imageName, text: text)
        return cell
    }
}
