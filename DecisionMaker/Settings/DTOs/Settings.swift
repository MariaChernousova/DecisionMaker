//
//  Settings.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 28.04.2022.
//

import Foundation

struct Settings: DecisionMakerInputDataSettable {
    let firstCriterion: Int
    let secondCriterion: Int
    let thirdCriterion: Int
    let fourthCriterion: Int
    let theBestAlternative: Int
    let incomparableAlternative: Int
    let theWorstAlternative: Int
    
    init(
        inputData: DecisionMakerInputData,
        theBestAlternative: Int,
        incomparableAlternative: Int,
        theWorstAlternative: Int
    ) {
        firstCriterion = inputData.firstCriterion
        secondCriterion = inputData.secondCriterion
        thirdCriterion = inputData.thirdCriterion
        fourthCriterion = inputData.fourthCriterion
        self.theBestAlternative = theBestAlternative
        self.incomparableAlternative = incomparableAlternative
        self.theWorstAlternative = theWorstAlternative
    }
}
