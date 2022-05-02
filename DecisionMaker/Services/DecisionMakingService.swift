//
//  DecisionMakingService.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 29.04.2022.
//

import Foundation

protocol DecisionMakerInputData {
    var firstCriterion: Int { get }
    var secondCriterion: Int { get }
    var thirdCriterion: Int { get }
    var fourthCriterion: Int { get }
}

protocol DecisionMakerInputDataSettable: DecisionMakerInputData {
    var selectedAlternative: Int { get }
}

protocol DecisionMakingServiceProvider {
    var result: [IterationResult] { get }
    var theBestResultRows: [Int] { get }
    var incomparableResultRows: [Int] { get }
    var theWorstResultRows: [Int] { get }
    var selectedResultRows: [Int] { get }
    
    func getDecision(from inputData: DecisionMakerInputData)
    func filterResult(from inputData: DecisionMakerInputDataSettable)
}

class DecisionMakingService: DecisionMakingServiceProvider {
    
    var result: [IterationResult] = []
    var theBestResultRows: [Int] = []
    var incomparableResultRows: [Int] = []
    var theWorstResultRows: [Int] = []
    var selectedResultRows: [Int] = []
    
    func getDecision(from inputData: DecisionMakerInputData) {
        
        var iteration = 0
        
        for firstCriteria in 1...inputData.firstCriterion {
            for secondCriteria in 1...inputData.secondCriterion {
                for thirdCriteria in 1...inputData.thirdCriterion {
                    for fourthCriteria in 1...inputData.fourthCriterion {
                        iteration = iteration + 1
                        let iterationResult = IterationResult(
                            iteration: iteration,
                            firstCriterionResult: firstCriteria,
                            secondCriterionResult: secondCriteria,
                            thirdCriterionResult: thirdCriteria,
                            fourthCriterionResult: fourthCriteria
                        )
                        result.append(iterationResult)
                    }
                }
            }
        }
    }
    
    func filterResult(from inputData: DecisionMakerInputDataSettable) {

        let selectedAlternativeResult = result.filter { result -> Bool in
            result.iteration == inputData.selectedAlternative
        }
        let selectedAlternative = selectedAlternativeResult[selectedAlternativeResult.startIndex]
        
        for result in result {

            if result.iteration < inputData.selectedAlternative,
               result.firstCriterionResult <= selectedAlternative.firstCriterionResult,
               result.secondCriterionResult <= selectedAlternative.secondCriterionResult,
               result.thirdCriterionResult <= selectedAlternative.thirdCriterionResult,
               result.fourthCriterionResult <= selectedAlternative.fourthCriterionResult {
                theBestResultRows.append(result.iteration)
            } else if result.iteration == inputData.selectedAlternative {
                selectedResultRows.append(result.iteration)
            } else if result.iteration > inputData.selectedAlternative,
               result.firstCriterionResult >= selectedAlternative.firstCriterionResult,
               result.secondCriterionResult >= selectedAlternative.secondCriterionResult,
               result.thirdCriterionResult >= selectedAlternative.thirdCriterionResult,
               result.fourthCriterionResult >= selectedAlternative.fourthCriterionResult {
                theWorstResultRows.append(result.iteration)
            } else {
                incomparableResultRows.append(result.iteration)
            }
        }
    }
}
