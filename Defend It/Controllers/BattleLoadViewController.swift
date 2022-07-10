//
//  BattleLoadViewController.swift
//  Defend It
//
//  Created by Роман Сенкевич on 11.07.22.
//

import UIKit

class BattleLoadViewController: UIViewController {
    
    // VC's
    var battleFieldVC: BattleFieldLoadDelegate = BattleFieldViewController()
    
    // UIView's
    var headingLabel: UILabel = UILabel()
    var timeLabel: UILabel = UILabel()
    
    // others vars
    var timer = Timer()
    var loadTime: Int = 5
    
    override func viewDidLoad() {
        view.backgroundColor = .blue
        setHeadingLabel()
        setTimeLabel()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setTimer()
        DispatchQueue.global(qos: .utility).async {
            self.loadBattleField()
        }
    }
    
    func loadBattleField() {
        battleFieldVC.assemblyModule()
    }
    
    func showBattleField() {
        battleFieldVC.modalPresentationStyle = .fullScreen
        self.present(battleFieldVC, animated: true)
    }
}


// funcs for timer
extension BattleLoadViewController {
    func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                               selector: #selector(self.updateTimer),userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        loadTime -= 1
        timeLabel.text = "\(loadTime) seconds"
        if loadTime == 0 {
            timer.invalidate()
            showBattleField()
        }
    }
}

// funcs for set labels
extension BattleLoadViewController {
    func setHeadingLabel() {
        headingLabel.text = "The battle will begin in"
        headingLabel.textColor = .white
        headingLabel.textAlignment = .center
        headingLabel.font = headingLabel.font.withSize(25)
        
        view.addSubview(headingLabel)
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100)
        ])
    }
    
    func setTimeLabel() {
        timeLabel.text = "\(loadTime) seconds"
        timeLabel.textColor = .white
        timeLabel.textAlignment = .center
        timeLabel.font = timeLabel.font.withSize(25)
        
        view.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
