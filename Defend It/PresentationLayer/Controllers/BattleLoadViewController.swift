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
        setProgressLabel()
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
    
    func setProgressLabel() {
        progressLabel.text = "Load battle scene... 0%"
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
    func createViperModelues(completed percent: Float) {
        DispatchQueue.main.async {
            self.changeProgress(into: percent/100.0)
            self.changeLabel(into: "create Viper Modelues: \(Int(self.loadProgress * 100))%")
        }
    }
    
    func createBattleMission(completed percent: Float) {
        DispatchQueue.main.async {
            self.changeProgress(into: percent/100.0)
            self.changeLabel(into: "create Battle Mission: \(Int(self.loadProgress  * 100))%")
        }
    }
    
    func createManagers(completed percent: Float) {
        DispatchQueue.main.async {
            self.changeProgress(into: percent/100.0)
            self.changeLabel(into: "create Managers: \(Int(self.loadProgress  * 100))%")
        }
    }
    
    func loadBattleLogic(completed percent: Float) {
        DispatchQueue.main.async {
            self.changeProgress(into: percent/100.0)
            self.changeLabel(into: "load Battle Logic: \(Int(self.loadProgress  * 100))%")
        }
    }
    
    func viewAssemblyDone() {
        DispatchQueue.main.async {
            self.changeProgress(into: 1)
            self.changeLabel(into: "Go!!!")
            self.showBattleField()
        }
    }
}
