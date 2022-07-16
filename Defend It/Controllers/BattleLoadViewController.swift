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
    var loadProgressBar: UIProgressView = UIProgressView()
    var progressLabel: UILabel = UILabel()
    
    // others vars
    var loadProgress: Float = 0.0
    
    override func viewDidLoad() {
        view.backgroundColor = .blue
        setLoadProgressBar()
        setHeadingLabel()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.global(qos: .utility).async {
            self.loadBattleField()
        }
    }
    
    func loadBattleField() {
        battleFieldVC.assemblyModule(delegate: self)
    }
    
    func showBattleField() {
        battleFieldVC.modalPresentationStyle = .fullScreen
        self.present(battleFieldVC, animated: true)
    }
}


// funcs for timer
extension BattleLoadViewController {
    
}

// funcs for set labels
extension BattleLoadViewController {
    func setLoadProgressBar() {
        loadProgressBar.progressTintColor = .white
        loadProgressBar.backgroundColor = .gray
        loadProgressBar.progress = 0
        view.addSubview(loadProgressBar)
        loadProgressBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadProgressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadProgressBar.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            loadProgressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            loadProgressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    func changeProgress(into value: Float) {
        loadProgress += value
        loadProgressBar.progress = loadProgress
    }
    
    func setHeadingLabel() {
        progressLabel.text = "The battle will begin in"
        progressLabel.textColor = .white
        progressLabel.textAlignment = .center
        progressLabel.font = progressLabel.font.withSize(25)
        
        view.addSubview(progressLabel)
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100)
        ])
    }
    
    func changeLabel(into text: String) {
        progressLabel.text = text
    }
}


extension BattleLoadViewController: BattleFieldAssemblyDelagate {
    func viperModulesInitCompleted() {
        DispatchQueue.main.async {
            self.changeProgress(into: 0.25)
            self.changeLabel(into: "viper Modules Init Completed: \(Int(self.loadProgress * 100))%")
        }
    }
    func managersInitCompleted() {
        DispatchQueue.main.async {
            self.changeProgress(into: 0.21)
            self.changeLabel(into: "managers Init Completed: \(Int(self.loadProgress * 100))%")
        }
    }
    func battleMissionCreated() {
        DispatchQueue.main.async {
            self.changeProgress(into: 0.37)
            self.changeLabel(into: "battle Mission Created: \(Int(self.loadProgress * 100))%")
        }
    }
    func battleLogicCreated() {
        DispatchQueue.main.async {
            self.changeProgress(into: 0.10)
            self.changeLabel(into: "battle Logic Created: \(Int(self.loadProgress * 100))%")
        }
    }
    func viewAssemblyCompleted() {
        DispatchQueue.main.async {
            self.changeProgress(into: 1)
            self.changeLabel(into: "Go!!!")
            self.showBattleField()
        }
    }
}
