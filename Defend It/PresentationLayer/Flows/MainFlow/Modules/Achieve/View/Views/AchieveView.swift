//
//  AchieveView.swift
//  Defend It
//
//  Created by Роман Сенкевич on 9.09.22.
//

import UIKit

protocol AchieveViewDelegate: AnyObject {
    func backButtonPressed()
    func getButtonPressed(rewards: BattleReward)
}

class AchieveView: UIView, UITableViewDelegate {

    var questsCollectionView: AchieveTableView!
    
    let mainView = UIView(frame: .zero)
    
    var backButton: UIButton!
    
    weak var delegate: AchieveViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        firstBorder(size: CGSize(width: 320, height: 400))
        setCollectionView()
        setBackButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func firstBorder(size: CGSize) {
        let mainView = UIView(frame: .zero)

        self.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainView.heightAnchor.constraint(equalToConstant: size.height),
            mainView.widthAnchor.constraint(equalToConstant: size.width)
        ])
        
        mainView.layer.cornerRadius = 30
        mainView.backgroundColor = .black
    }
    
    func setCollectionView() {
        questsCollectionView = AchieveTableView()
        questsCollectionView.delegate = self
        self.addSubview(questsCollectionView)
        
        questsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questsCollectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            questsCollectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            questsCollectionView.heightAnchor.constraint(equalToConstant: 350),
            questsCollectionView.widthAnchor.constraint(equalToConstant: 285)

        ])
    }
    
    func setBackButton() {
        backButton = UIButton()
        self.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        let backImage = UIImage(systemName: "arrowshape.turn.up.backward")!
        let targetSize = CGSize(width: 50, height: 50)
        
        let scaledImage = backImage.scalePreservingAspectRatio(targetSize: targetSize)
        
        backButton.setImage(scaledImage, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    @objc func backButtonPressed() {
        delegate.backButtonPressed()
    }
}

extension AchieveView: AchieveTableViewDelegate {
    
    func getButtonPressed(rewards: BattleReward) {
        delegate.getButtonPressed(rewards: rewards)
    }
}


