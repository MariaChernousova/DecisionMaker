//
//  MainCoordinator.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 24.04.2022.
//

import UIKit

protocol MainCoordinatorProvider {
    func openSettingsScreen(with inputData: DecisionMakerInputData)
    func openAlternativesScreen(with inputData: DecisionMakerInputData)
}

class MainCoordinator: Coordinator {
    
    private let rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewModel = MainViewModel(coordinator: self)
        let viewController = MainViewController(viewModel: viewModel)
        
        rootViewController.pushViewController(viewController, animated: true)
    }
}

extension MainCoordinator: MainCoordinatorProvider {
    
    func openSettingsScreen(with inputData: DecisionMakerInputData) {
        SettingsCoordinator(rootViewController: rootViewController, inputData: inputData, inputDataSettable: nil).start()
    }
    
    func openAlternativesScreen(with inputData: DecisionMakerInputData) {
        AlternativesCoordinator(rootViewController: rootViewController, inputData: inputData, inputDataSettable: nil).start()
    }
}
