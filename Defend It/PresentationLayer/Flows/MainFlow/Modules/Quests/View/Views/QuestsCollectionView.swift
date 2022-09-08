//
//  QuestsCollectionView.swift
//  Defend It
//
//  Created by Роман Сенкевич on 5.09.22.
//

import UIKit

class QuestsCollectionView: UIView, UITableViewDataSource, UITableViewDelegate {

    
    var tableView: UITableView?
    
    let dailyQuests = UserImp.shared.gameAccount?.dailyQuests
    
    let testArrayOfRewardItems: [(String, EquipmentImageNames, String)] =
       [("press done button", EquipmentImageNames.blade, "1"),
        ("complete 1 mission", EquipmentImageNames.arch, "2"),
        ("complete 2 mission", EquipmentImageNames.hammer, "3"),
        ("complete 3 mission", EquipmentImageNames.blade, "4"),
        ("complete 4 mission", EquipmentImageNames.flask, "6"),
        ("complete 5 mission", EquipmentImageNames.money, "7"),
        ("complete 3 mission", EquipmentImageNames.diamond, "19"),
        ("complete 3 mission", EquipmentImageNames.shield, "16")]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionView()
        
        self.tableView?.allowsSelection = false
//        tableView?.delaysContentTouches = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setCollectionView() {
        tableView = UITableView(frame: .zero)
        guard let tableView = tableView else {return}
        tableView.register(QuestCellImp.self, forCellReuseIdentifier: QuestCellImp.identifier)
        
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            tableView.heightAnchor.constraint(equalTo: self.heightAnchor),
            tableView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        
        tableView.backgroundColor = .green
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentQuest = dailyQuests!.tasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestCellImp.identifier, for: indexPath) as! QuestCell
        cell.configure(task: currentQuest)
        cell.setupDelegate(self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dailyQuests?.tasks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}


extension QuestsCollectionView: QuestCellDelegate {
    
    func getButtonPressed() {
        print("getButtonPressed")
    }
}
