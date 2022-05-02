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
            service.filterResult(from: inputDataSettable)
        } else if let inputData = inputData {
            service.getDecision(from: inputData)
        }
        triggerUpdateAction()
    }
    
    private func triggerUpdateAction() {
        let result = service.result
        let theBestResultRows = service.theBestResultRows
        let incomparableResultRows = service.incomparableResultRows
        let theWorstResultRows = service.theWorstResultRows
        let selectedResultRows = service.selectedResultRows
        var alternativeDecorator = result.map { iterationResult in
            AlternativeDecorator(
                .alternative(
                    AlternativesCellDataConfigurator(
                        iterationTitle: "\(iterationResult.iteration)",
                        firstCriterionTitle: "K1:\(iterationResult.firstCriterionResult)",
                        secondCriterionTitle: "K2:\(iterationResult.secondCriterionResult)",
                        thirdCriterionTitle: "K3:\(iterationResult.thirdCriterionResult)",
                        fourthCriterionTitle: "K4:\(iterationResult.fourthCriterionResult)",
                        theBestResultRows: theBestResultRows,
                        incomparableResultRows: incomparableResultRows,
                        theWorstResultRows: theWorstResultRows,
                        selectedResultRows: selectedResultRows
                    )
                )
            )
        }
        if theBestResultRows != [],
           incomparableResultRows != [],
           theWorstResultRows != [] {
            alternativeDecorator.append(
                AlternativeDecorator(
                    .result(
                        AlternativeResultCellDataConfigurator(
                            theBestResultRows: theBestResultRows,
                            incomparableResultRows: incomparableResultRows,
                            theWorstResultRows: theWorstResultRows
                        )
                    )
                )
            )
        }
        updateAction(alternativeDecorator)
    }
}

