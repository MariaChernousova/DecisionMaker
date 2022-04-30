//
//  Result.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 30.04.2022.
//

import Foundation

struct IterationResult {
    let iteration: Int
    let firstCriterionResult: String
    let secondCriterionResult: String
    let thirdCriterionResult: String
    let fourthCriterionResult: String
}

struct Result {
    let result: [IterationResult]
}

struct ResultWithSettings {
    let result: [IterationResult]
    let theBestResultRows: [Int]
    let incomparableResultRows: [Int]
    let theWorstResultRows: [Int]
}
