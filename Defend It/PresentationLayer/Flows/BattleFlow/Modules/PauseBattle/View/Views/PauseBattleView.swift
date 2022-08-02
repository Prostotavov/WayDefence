//
//  PauseBattleView.swift
//  Defend It
//
//  Created by Роман Сенкевич on 26.07.22.
//

import UIKit

protocol PauseBattleViewDelegate: AnyObject {
    func playBattonPressed()
    func goToHomePagePressed()
    
    func restart()
    func quit()
    func play()
}

class PauseBattleView: UIView {
    
    var viewImage: UIView!
    var pauseLabel: UILabel!
    
    var firstButton: UIButton!
    var secondButton: UIButton!
    var thirdButton: UIButton!
    
    let viewImageHeight: CGFloat = 383
    let viewImageWeight: CGFloat = 235
    
    lazy var blurredView: UIView = {
        // 1. create container view
        let containerView = UIView()
        // 2. create custom blur view
        let blurEffect = UIBlurEffect(style: .light)
        let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.2)
        customBlurEffectView.frame = self.bounds
        // 3. create semi-transparent black view
        let dimmedView = UIView()
        dimmedView.backgroundColor = .white.withAlphaComponent(0.1)
        dimmedView.frame = self.bounds
        
        // 4. add both as subviews
        containerView.addSubview(customBlurEffectView)
        containerView.addSubview(dimmedView)
        return containerView
    }()
    
    weak var delegate: PauseBattleViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        addViewImage()
        addBluerBackground()
        addLabel()
        addFirstButton()
        addSecondButton()
        addThirdButton()
        
        firstButton.addTarget(self, action: #selector(touchDownFirst), for: .touchDown)
        secondButton.addTarget(self, action: #selector(touchDownSecond), for: .touchDown)
        thirdButton.addTarget(self, action: #selector(touchDownThird), for: .touchDown)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addBluerBackground() {
        self.addSubview(blurredView)
        self.sendSubviewToBack(blurredView)
    }
    
    @objc func touchDownFirst() {
        self.firstButton.setTitleColor(.white.withAlphaComponent(0.6), for: .normal)
    }
    
    @objc func touchDownSecond() {
        self.secondButton.setTitleColor(.white.withAlphaComponent(0.6), for: .normal)
    }
    
    @objc func touchDownThird() {
        self.thirdButton.setTitleColor(.white.withAlphaComponent(0.6), for: .normal)
    }
    
    @objc func play() {
        self.firstButton.setTitleColor(.gray, for: .normal)
        delegate.play()
    }
    
    @objc func quit() {
        self.secondButton.setTitleColor(.gray, for: .normal)
        delegate.quit()
    }
    
    @objc func restart() {
        self.thirdButton.setTitleColor(.gray, for: .normal)
        delegate.restart()
    }
    
    
    
    func addLabel() {
        pauseLabel = UILabel()
        pauseLabel.text = "Pause"
        pauseLabel.textColor = .gray
        pauseLabel.textAlignment = .center
        pauseLabel.font = UIFont(name: pauseLabel.font.fontName, size: 30)
        pauseLabel.translatesAutoresizingMaskIntoConstraints = false
        viewImage.addSubview(pauseLabel)
        
        NSLayoutConstraint.activate([
            pauseLabel.centerXAnchor.constraint(equalTo: viewImage.centerXAnchor),
            pauseLabel.topAnchor.constraint(equalTo: viewImage.topAnchor, constant: 10),
            pauseLabel.heightAnchor.constraint(equalToConstant: 30),
            pauseLabel.widthAnchor.constraint(equalToConstant: 90)
        ])
        
    }
    
    
    
    func addFirstButton() {
        firstButton = UIButton()
        firstButton.setTitle("Play", for: .normal)
        firstButton.setTitleColor(.gray, for: .normal)
        firstButton.titleLabel?.textAlignment = .center
        firstButton.titleLabel?.font = UIFont(name: pauseLabel.font.fontName, size: 30)
        
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        firstButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        viewImage.addSubview(firstButton)
        
        NSLayoutConstraint.activate([
            firstButton.centerXAnchor.constraint(equalTo: viewImage.centerXAnchor),
            firstButton.topAnchor.constraint(equalTo: viewImage.topAnchor, constant: 90),
            firstButton.heightAnchor.constraint(equalToConstant: 30),
            firstButton.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    
    
    func addSecondButton() {
        secondButton = UIButton()
        secondButton.setTitle("Quit", for: .normal)
        secondButton.setTitleColor(.gray, for: .normal)
        secondButton.titleLabel?.textAlignment = .center
        secondButton.titleLabel?.font = UIFont(name: (secondButton.titleLabel?.font.fontName)!, size: 30)
        
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.addTarget(self, action: #selector(quit), for: .touchUpInside)
        viewImage.addSubview(secondButton)
        
        NSLayoutConstraint.activate([
            secondButton.centerXAnchor.constraint(equalTo: viewImage.centerXAnchor),
            secondButton.topAnchor.constraint(equalTo: viewImage.topAnchor, constant: 145),
            secondButton.heightAnchor.constraint(equalToConstant: 30),
            secondButton.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    
    
    func addThirdButton() {
        thirdButton = UIButton()
        thirdButton.setTitle("Restart", for: .normal)
        thirdButton.setTitleColor(.gray, for: .normal)
        thirdButton.titleLabel?.textAlignment = .center
        thirdButton.titleLabel?.font = UIFont(name: (thirdButton.titleLabel?.font.fontName)!, size: 30)
        
        thirdButton.translatesAutoresizingMaskIntoConstraints = false
        thirdButton.addTarget(self, action: #selector(restart), for: .touchUpInside)
        viewImage.addSubview(thirdButton)
        
        NSLayoutConstraint.activate([
            thirdButton.centerXAnchor.constraint(equalTo: viewImage.centerXAnchor),
            thirdButton.topAnchor.constraint(equalTo: viewImage.topAnchor, constant: 205),
            thirdButton.heightAnchor.constraint(equalToConstant: 30),
            thirdButton.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    func addViewImage() {
        viewImage = UIView()
        self.addSubview(viewImage)
        
        viewImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            viewImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            viewImage.heightAnchor.constraint(equalToConstant: viewImageHeight),
            viewImage.widthAnchor.constraint(equalToConstant: viewImageWeight)
        ])
        
        let imageView = UIImageView(image: .init(named: "PauseBattleImageView"))
        imageView.frame = CGRect(x: 0, y: 0, width: viewImageWeight, height: viewImageHeight)
        viewImage.addSubview(imageView)
        
        
    }
}
