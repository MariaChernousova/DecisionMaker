//
//  AlternativeRowComponent.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 29.04.2022.
//

import Foundation

enum AlternativeRowComponent: CaseIterable {
    case alternative(AlternativesDataConfigurator)
    case button(MainButtonDataConfigurator)
    
    static let allCases: [AlternativeRowComponent] = [
        .alternative(AlternativesDataConfigurator.empty),
        .button(MainButtonDataConfigurator.empty)
    ]
    
    var dataConfigurable: TableViewCellConfigurable {
        switch self {
        case .alternative(let alternativesDataConfigurator):
            return alternativesDataConfigurator
        case .button(let mainButtonDataConfigurator):
            return mainButtonDataConfigurator
        }
    }
}
