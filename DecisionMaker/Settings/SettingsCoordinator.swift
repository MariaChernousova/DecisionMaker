//
//  SettingsCoordinator.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 24.04.2022.
//

import UIKit

protocol SettingsCoordinatorProvider {
    func openAlternativesScreen(with inputDataSettable: DecisionMakerInputDataSettable)
}

class SettingsCoordinator: Coordinator {
    
    private let rootViewController: UINavigationController
    private let inputData: DecisionMakerInputData?
    private let inputDataSettable: DecisionMakerInputDataSettable?
    
    init(rootViewController: UINavigationController, inputData: DecisionMakerInputData?, inputDataSettable: DecisionMakerInputDataSettable?) {
        self.rootViewController = rootViewController
        self.inputData = inputData
        self.inputDataSettable = inputDataSettable
    }
    
    func start() {
        guard let inputData = inputData else { return }
        let viewModel = SettingsViewModel(coordinator: self, inputData: inputData)
        let viewController = MainViewController(viewModel: viewModel)
        
        rootViewController.pushViewController(viewController, animated: true)
    }
}

extension SettingsCoordinator: SettingsCoordinatorProvider {
    
    func openAlternativesScreen(with inputDataSettable: DecisionMakerInputDataSettable) {
        AlternativesCoordinator(rootViewController: rootViewController, inputData: inputData, inputDataSettable: inputDataSettable).start()
    }
}
