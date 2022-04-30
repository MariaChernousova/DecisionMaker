//
//  AppCoordinator.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 24.04.2022.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let navigationController = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = navigationController
        
        let coordinator = MainCoordinator(rootViewController: navigationController)
        coordinator.start()
        
        window.makeKeyAndVisible()
    }
}
