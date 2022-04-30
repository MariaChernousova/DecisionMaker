//
//  AlternativesViewModel.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 24.04.2022.
//

import Foundation

protocol AlternativesViewModelProvider {
    var updateAction: ([AlternativeDecorator]) -> Void { get set }
    func didLoad()
}

class AlternativesViewModel: AlternativesViewModelProvider {
    
    var updateAction: ([AlternativeDecorator]) -> Void = { _ in }
    
    var coordinator: AlternativesCoordinatorProvider
    private var service: DecisionMakingServiceProvider
    private let inputData: DecisionMakerInputData?
    private let inputDataSettable: DecisionMakerInputDataSettable?
    
    init(coordinator: AlternativesCoordinatorProvider, service: DecisionMakingServiceProvider, inputData: DecisionMakerInputData?, inputDataSettable: DecisionMakerInputDataSettable?) {
        self.coordinator = coordinator
        self.service = service
        self.inputData = inputData
        self.inputDataSettable = inputDataSettable
    }
    
    func didLoad() {
        if let inputDataSettable = inputDataSettable {
            service.getDecision(from: inputDataSettable)
        } else if let inputData = inputData {
            service.getDecision(from: inputData)
        }
        triggerUpdateAction()
    }
    
    private func triggerUpdateAction() {
        let result = service.result
        let alternativeDecorator = result.map { iterationResult in
            AlternativeDecorator(
                .alternative(
                    AlternativesDataConfigurator(
                        iterationTitle: "\(iterationResult.iteration)",
                        firstCriterionTitle: iterationResult.firstCriterionResult,
                        secondCriterionTitle: iterationResult.secondCriterionResult,
                        thirdCriterionTitle: iterationResult.thirdCriterionResult,
                        fourthCriterionTitle: iterationResult.fourthCriterionResult)
                )
            )
            
        }
        updateAction(alternativeDecorator)
    }
}

