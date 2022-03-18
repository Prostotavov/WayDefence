// 
//  HomePagePresenter.swift
//  Defend It
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation

class HomePagePresenter: HomePageViewOutput, HomePageInteractorOutput {
    
    weak var view: HomePageViewInput!
    var interactor: HomePageInteractorInput!
    var router: HomePageRouterInput!
    
    func startGame() {
        router.showBattleField()
    }
    
}
