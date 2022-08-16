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

class WinBattleView: UIView {
    
    let startButtonHeight: CGFloat = 50
    let startButtonWidth: CGFloat = 300
    
    let statusLabelHeight: CGFloat = 50
    let statusLabelWidth: CGFloat = 300
    
    var startButton = UIButton()
    var statusLabel = UILabel()
    var rewardLabel = UILabel()
    
    weak var delegate: WinBattleViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        setStartButton()
        setStatusLabel()
        setRewardLabel()
        startButton.addTarget(self, action: #selector(goToHomePagePressed), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
            rewardLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
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
            startButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 100),
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
