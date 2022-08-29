//
//  WinBattleView.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import UIKit

protocol WinBattleViewDelegate: AnyObject {
    func goToHomePagePressed()
}

class WinBattleView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let startButtonHeight: CGFloat = 50
    let startButtonWidth: CGFloat = 300
    
    let statusLabelHeight: CGFloat = 50
    let statusLabelWidth: CGFloat = 300
    
    var startButton = UIButton()
    var statusLabel = UILabel()
    var rewardLabel = UILabel()
    
    
    let collectionViewHeight: CGFloat = 200
    let collectionViewWidth: CGFloat = 300
    var collectionView: UICollectionView?
    
    let testArrayOfRewardItems: [(ImageNames, String)] = [
        (ImageNames.blade, "1"), (ImageNames.arch, "2"), (ImageNames.hammer, "1"),
        (ImageNames.diamond, "10"), (ImageNames.money, "175"), (ImageNames.flask, "7")
    ]
    
    weak var delegate: WinBattleViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        setStartButton()
        setStatusLabel()
        setRewardLabel()
        setCollectionView()
        startButton.addTarget(self, action: #selector(goToHomePagePressed), for: .touchUpInside)
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
        
        collectionView.backgroundColor = .yellow
        
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
    
    func setStatusLabel() {
        
        self.addSubview(statusLabel)
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statusLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            statusLabel.heightAnchor.constraint(equalToConstant: statusLabelHeight),
            statusLabel.widthAnchor.constraint(equalToConstant: statusLabelWidth)
        ])
        
        statusLabel.backgroundColor = .systemBlue
        statusLabel.text = "You Are Win"
        statusLabel.textAlignment = .center
    }
    
    func setRewardLabel() {
        
        self.addSubview(rewardLabel)
        
        rewardLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rewardLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            rewardLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -70),
            rewardLabel.heightAnchor.constraint(equalToConstant: statusLabelHeight),
            rewardLabel.widthAnchor.constraint(equalToConstant: statusLabelWidth)
        ])
        
        rewardLabel.backgroundColor = .systemBlue
        rewardLabel.text = "Your reward"
        rewardLabel.textAlignment = .center
    }
    
    func setStartButton() {
        
        self.addSubview(startButton)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            startButton.heightAnchor.constraint(equalToConstant: startButtonHeight),
            startButton.widthAnchor.constraint(equalToConstant: startButtonWidth)
        ])
        
        startButton.backgroundColor = .systemBlue
        startButton.setTitle("Tap to go Home Page", for: .normal)
    }
    
    @objc func goToHomePagePressed() {
        delegate.goToHomePagePressed()
    }
    
}

//MARK: -Canvas-

import SwiftUI

struct WinBattleCanvas: PreviewProvider {
    static var previews: some View {
        UIViewCanvas().edgesIgnoringSafeArea(.all)
    }
    
    struct UIViewCanvas: UIViewRepresentable {
        
        func makeUIView(context: Context) -> some UIView {
            return WinBattleView(frame: CGRect.zero)
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
        }
    }
    
    struct UIViewControllerCanvas: UIViewControllerRepresentable {
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return WinBattleViewController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
