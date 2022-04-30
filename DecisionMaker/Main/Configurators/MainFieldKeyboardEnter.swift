//
//  MainFieldKeyboardEnter.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 29.04.2022.
//

import Foundation

enum MainFieldKeyboardEnter: Hashable {
    case numpad
    case picker([Int])
    
    private static let numpadIdentifier = UUID()
    
    static func == (lhs: MainFieldKeyboardEnter, rhs: MainFieldKeyboardEnter) -> Bool {
        switch (lhs, rhs) {
        case (.numpad, .numpad):
            return true
        case (.picker(let lhsValues), .picker(let rhsValues)):
            return lhsValues == rhsValues
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .numpad:
            hasher.combine(MainFieldKeyboardEnter.numpadIdentifier)
        case .picker(let values):
            hasher.combine(values)
        }
    }
}
