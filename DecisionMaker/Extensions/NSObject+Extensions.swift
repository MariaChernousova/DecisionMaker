//
//  NSObject+Extensions.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 28.04.2022.
//

import Foundation

extension NSObject {
    
    static var identifier: String {
        "\(String(describing: self))Identifier"
    }
}
