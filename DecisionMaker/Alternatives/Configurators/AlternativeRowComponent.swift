//
//  AlternativeRowComponent.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 29.04.2022.
//

import Foundation

enum AlternativeRowComponent: CaseIterable {
    case alternative(AlternativesCellDataConfigurator)
    case result(AlternativeResultCellDataConfigurator)
    
    static let allCases: [AlternativeRowComponent] = [
        .alternative(AlternativesCellDataConfigurator.empty),
        .result(AlternativeResultCellDataConfigurator.empty)
    ]
    
    var dataConfigurable: TableViewCellConfigurable {
        switch self {
        case .alternative(let alternativesDataConfigurator):
            return alternativesDataConfigurator
        case .result(let alternativeResultCellDataConfigurator):
            return alternativeResultCellDataConfigurator
        }
    }
}
