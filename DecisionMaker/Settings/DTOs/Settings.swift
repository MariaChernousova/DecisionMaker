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
    let selectedAlternative: Int
    
    init(
        inputData: DecisionMakerInputData,
        selectedAlternative: Int
    ) {
        firstCriterion = inputData.firstCriterion
        secondCriterion = inputData.secondCriterion
        thirdCriterion = inputData.thirdCriterion
        fourthCriterion = inputData.fourthCriterion
        self.selectedAlternative = selectedAlternative
    }
}
