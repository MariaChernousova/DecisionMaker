//
//  MainRowComponent.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 28.04.2022.
//

import Foundation

enum MainRowComponent: CaseIterable {
    case field(MainFieldDataConfigurator)
    case button(MainButtonDataConfigurator)
    
    static let allCases: [MainRowComponent] = [
        .field(MainFieldDataConfigurator.empty),
        .button(MainButtonDataConfigurator.empty)
    ]
    
    var dataConfigurable: TableViewCellConfigurable {
        switch self {
        case .field(let mainFieldDataConfigurator):
            return mainFieldDataConfigurator
        case .button(let mainButtonDataConfigurator):
            return mainButtonDataConfigurator
        }
    }
}
