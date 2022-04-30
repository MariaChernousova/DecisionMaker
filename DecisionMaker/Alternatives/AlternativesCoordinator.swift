//
//  AlternativesCoordinator.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 24.04.2022.
//

import UIKit

protocol AlternativesCoordinatorProvider {

}

class AlternativesCoordinator: Coordinator {
    
    private let rootViewController: UINavigationController
    private let inputData: DecisionMakerInputData?
    private let inputDataSettable: DecisionMakerInputDataSettable?
    
    init(rootViewController: UINavigationController, inputData: DecisionMakerInputData?, inputDataSettable: DecisionMakerInputDataSettable?) {
        self.rootViewController = rootViewController
        self.inputData = inputData
        self.inputDataSettable = inputDataSettable
    }
    
    func start() {
        let service = DecisionMakingService()
        let viewModel = AlternativesViewModel(coordinator: self, service: service, inputData: inputData, inputDataSettable: inputDataSettable)
        let viewController = AlternativesViewController(viewModel: viewModel)
        
        rootViewController.pushViewController(viewController, animated: true)
    }
}

extension AlternativesCoordinator: AlternativesCoordinatorProvider {}
