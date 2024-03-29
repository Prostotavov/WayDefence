// 
//  HomePageViewController.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import UIKit

class HomePageViewController: UIViewController, HomePageViewInput, HomePageViewDelegate, HomePageViewCoordinatorOutput {
    
    var output: HomePageViewOutput!
    var assembler: HomePageAssemblyProtocol = HomePageAssembly()
    
    var onStartBattle: (() -> Void)?
    
    var homePageView = HomePageView()
    
    override func loadView() {
        view = homePageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assembler.assemblyModuleForViewInput(viewInput: self)
        homePageView.delegate = self
    }
    
    func startButtonPressed() {
        output.onStartBattle()
    }
    
}

