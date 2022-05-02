//
//  AlternativeResultCellDataConfigurator.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 01.05.2022.
//

import UIKit

class AlternativeResultCellDataConfigurator: AlternativesTableViewResultCellDataRepresentable {
    
    static let empty = AlternativeResultCellDataConfigurator(
        theBestResultRows: [],
        incomparableResultRows: [],
        theWorstResultRows: []
    )
    
    let theBestResultRows: [Int]
    let incomparableResultRows: [Int]
    let theWorstResultRows: [Int]
    
    init(
        theBestResultRows: [Int],
        incomparableResultRows: [Int],
        theWorstResultRows: [Int]
    ) {
        self.theBestResultRows = theBestResultRows
        self.incomparableResultRows = incomparableResultRows
        self.theWorstResultRows = theWorstResultRows
    }
}

extension AlternativeResultCellDataConfigurator: Hashable {
    
    static func == (lhs: AlternativeResultCellDataConfigurator, rhs: AlternativeResultCellDataConfigurator) -> Bool {
        lhs.theBestResultRows == rhs.theBestResultRows &&
        lhs.incomparableResultRows == rhs.incomparableResultRows &&
        lhs.theWorstResultRows == rhs.theWorstResultRows
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(theBestResultRows)
        hasher.combine(incomparableResultRows)
        hasher.combine(theWorstResultRows)
    }
}

extension AlternativeResultCellDataConfigurator: TableViewCellConfigurable {
    
    var identifier: AnyHashable { self }
    
    func registerIdentifier(in tableView: UITableView) {
        tableView.register(
            AlternativesTableViewResultCell.self,
            forCellReuseIdentifier: AlternativesTableViewResultCell.identifier
        )
    }
    
    func configureCell(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: AlternativesTableViewResultCell.identifier,
            for: indexPath
        ) as? AlternativesTableViewResultCell
        cell?.configure(with: self)
        return cell
    }
}
