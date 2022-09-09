//
//  QuestsView.swift
//  Defend It
//
//  Created by Роман Сенкевич on 5.09.22.
//

import UIKit

protocol QuestsViewDelegate: AnyObject {
    func backButtonPressed()
    func getButtonPressed(rewards: BattleReward)
}

class QuestsView: UIView, UITableViewDelegate {

    var questsCollectionView: QuestsCollectionView!
    
    let mainView = UIView(frame: .zero)
    
    var backButton: UIButton!
    
    weak var delegate: QuestsViewDelegate!
    
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
        questsCollectionView = QuestsCollectionView()
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

extension QuestsView: QuestsCollectionViewDelegate {
    
    func getButtonPressed(rewards: BattleReward) {
        delegate.getButtonPressed(rewards: rewards)
    }
}

