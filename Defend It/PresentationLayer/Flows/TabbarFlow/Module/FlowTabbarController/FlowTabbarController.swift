//
//  FlowTabbarController.swift
//  Defend It
//
//  Created by Роман Сенкевич on 28.07.22.
//

import UIKit

class FlowTabbarController: UITabBarController , UITabBarControllerDelegate, FlowTabbarCoordinatorOutput {
    
    var onMainFlow: ((UINavigationController) -> ())?
    var onBattleMapFlow: ((UINavigationController) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
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
        
//        setItemsImage()
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
            item.image = #imageLiteral(resourceName: "ballistaSelectIcon")
            item.selectedImage = #imageLiteral(resourceName: "doneSelectIcon")
        })
    }
}

