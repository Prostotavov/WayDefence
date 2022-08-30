//
//  FlowTabbarController.swift
//  Defend It
//
//  Created by Роман Сенкевич on 28.07.22.
//

import UIKit

class FlowTabbarController: UITabBarController , UITabBarControllerDelegate, FlowTabbarCoordinatorOutput, FlowTabbarViewInput {
    
    var output: FlowTabbarViewOutput!
    var assembler: FlowTabbarAssemblyProtocol = FlowTabbarAssembly()
    
    var onMainFlow: ((UINavigationController) -> ())?
    var onBattleMapFlow: ((UINavigationController) -> ())?
    
    var topBarView: FlowTabbarTopBarView!
    var bagViewButton: BagViewButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        assembler.assemblyModuleForViewInput(viewInput: self)
        setupTopBarView()
        setupBagView()
        output.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nvc1 = UINavigationController()
        let nvc2 = UINavigationController()
        let controllers = [nvc1, nvc2]
        self.viewControllers = controllers
        startRootFlows()
    }
    
    func startRootFlows() {
        
        if let controller = viewControllers?[0] as? UINavigationController {
            onMainFlow?(controller)
        }
        
        if let controller = viewControllers?[1] as? UINavigationController {
            onBattleMapFlow?(controller)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setItemsImage()
        removeTabbarItemsText()
    }
    
    private func removeTabbarItemsText() {
        
        tabBar.items![0].title = "Home Page"
        tabBar.items![0].imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        tabBar.items![1].title = "Battle Map"
        tabBar.items![1].imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
    }
    
    private func setItemsImage() {
        
        tabBar.items?.forEach({ (item) in
            item.image = UIImage(systemName: "folder.circle")
            item.selectedImage = UIImage(systemName: "pencil.tip.crop.circle")
        })
    }
}

// topBarView
extension FlowTabbarController {
    func setupTopBarView() {
        topBarView = FlowTabbarTopBarView(frame: view.frame)
        view.addSubview(topBarView)
        topBarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topBarView.topAnchor.constraint(equalTo: view.topAnchor),
            topBarView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            topBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func displayValue(of valueType: EconomicAccountValueTypes, to value: Int) {
        topBarView.displayValue(of: valueType, to: value)
    }
}

// bag view
extension FlowTabbarController {
    func setupBagView() {
        bagViewButton = BagViewButton()
        view.addSubview(bagViewButton)
        bagViewButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bagViewButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            bagViewButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
        ])
        
        bagViewButton.addTarget(self, action: #selector(bagViewButtonPressed), for: .touchUpInside)
    }
    
    @objc func bagViewButtonPressed() {
        print("Heeeeelllloooo")
    }
}
