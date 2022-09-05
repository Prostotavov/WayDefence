//
//  QuestsCollectionView.swift
//  Defend It
//
//  Created by Роман Сенкевич on 5.09.22.
//

import UIKit

class QuestsCollectionView: UIView, UITableViewDataSource, UITableViewDelegate {

    
    var tableView: UITableView?
    
    let testArrayOfRewardItems: [(String, String)] = [("press done button", "1 arch"), ("complete 1 mission", "2 arch"), ("complete 2 mission", "2 blade"), ("complete 3 mission", "4 hammer"), ("complete 4 mission", "7 points"),
        ("complete 3 mission", "4 hammer"), ("complete 3 mission", "4 hammer"), ("complete 3 mission", "4 hammer")]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionView()
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestCellImp.identifier, for: indexPath) as! QuestCell
        cell.backgroundColor = .white
        cell.textLabel?.text = testArrayOfRewardItems[indexPath.row].0
//        cell.configure(image: imageName, text: text)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        testArrayOfRewardItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

