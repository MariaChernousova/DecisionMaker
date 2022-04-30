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
    var theBestAlternative: Int { get }
    var incomparableAlternative: Int { get }
    var theWorstAlternative: Int { get }
}

protocol DecisionMakingServiceProvider {
    var result: [IterationResult] { get }
    var theBestResultRows: [Int] { get }
    var incomparableResultRows: [Int] { get }
    var theWorstResultRows: [Int] { get }
    
    func getDecision(from inputData: DecisionMakerInputData)
    func getDecision(from inputData: DecisionMakerInputDataSettable)
}

class DecisionMakingService: DecisionMakingServiceProvider {
    
    var result: [IterationResult] = []
    var theBestResultRows: [Int] = []
    var incomparableResultRows: [Int] = []
    var theWorstResultRows: [Int] = []
    
    func getDecision(from inputData: DecisionMakerInputData) {
        var iteration = 0
        for firstCriteria in 1...inputData.firstCriterion {
            for secondCriteria in 1...inputData.secondCriterion {
                for thirdCriteria in 1...inputData.thirdCriterion {
                    for fourthCriteria in 1...inputData.fourthCriterion {
                        iteration = iteration + 1
                        print("\(iteration) K1:\(firstCriteria), K2:\(secondCriteria), K3:\(thirdCriteria), K4:\(fourthCriteria)")
                        let iterationResult = IterationResult(
                            iteration: iteration,
                            firstCriterionResult: "K1:\(firstCriteria)",
                            secondCriterionResult: "K2:\(secondCriteria)",
                            thirdCriterionResult: "K3:\(thirdCriteria)",
                            fourthCriterionResult: "K4:\(fourthCriteria)"
                        )
                        result.append(iterationResult)
                    }
                }
            }
        }
    }
    
    func getDecision(from inputData: DecisionMakerInputDataSettable) {
        var iteration = 0
        for firstCriteria in 1...inputData.firstCriterion {
            for secondCriteria in 1...inputData.secondCriterion {
                for thirdCriteria in 1...inputData.thirdCriterion {
                    for fourthCriteria in 1...inputData.fourthCriterion {
                        iteration = iteration + 1
                        if iteration == inputData.theBestAlternative {
                            print("🟢\(iteration)")
                            theBestResultRows.append(iteration)
                        }
                        if iteration == inputData.incomparableAlternative {
                            print("🟢\(iteration)")
                            incomparableResultRows.append(iteration)
                        }
                        if iteration == inputData.theWorstAlternative {
                            print("🟢\(iteration)")
                            theWorstResultRows.append(iteration)
                        }
                        print("\(iteration) K1:\(firstCriteria), K2:\(secondCriteria), K3:\(thirdCriteria), K4:\(fourthCriteria)")
                        let iterationResult = IterationResult(
                            iteration: iteration,
                            firstCriterionResult: "K1:\(firstCriteria)",
                            secondCriterionResult: "K2:\(secondCriteria)",
                            thirdCriterionResult: "K3:\(thirdCriteria)",
                            fourthCriterionResult: "K4:\(fourthCriteria)"
                        )
                        result.append(iterationResult)
                    }
                }
            }
        }
    }
}



