//
//  AlternativesDataConfigurator.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 29.04.2022.
//

import UIKit

class AlternativesCellDataConfigurator: AlternativesTableViewCellDataRepresentable {
    
    static let empty = AlternativesCellDataConfigurator(
        iterationTitle: "",
        firstCriterionTitle: "",
        secondCriterionTitle: "",
        thirdCriterionTitle: "",
        fourthCriterionTitle: "",
        theBestResultRows: [],
        incomparableResultRows: [],
        theWorstResultRows: [],
        selectedResultRows: []
    )
    
    let iterationTitle: String
    let firstCriterionTitle: String
    let secondCriterionTitle: String
    let thirdCriterionTitle: String
    let fourthCriterionTitle: String
    let theBestResultRows: [Int]?
    let incomparableResultRows: [Int]?
    let theWorstResultRows: [Int]?
    let selectedResultRows: [Int]?
    
    init(
        iterationTitle: String,
        firstCriterionTitle: String,
        secondCriterionTitle: String,
        thirdCriterionTitle: String,
        fourthCriterionTitle: String,
        theBestResultRows: [Int]?,
        incomparableResultRows: [Int]?,
        theWorstResultRows: [Int]?,
        selectedResultRows: [Int]?
    ) {
        self.iterationTitle = iterationTitle
        self.firstCriterionTitle = firstCriterionTitle
        self.secondCriterionTitle = secondCriterionTitle
        self.thirdCriterionTitle = thirdCriterionTitle
        self.fourthCriterionTitle = fourthCriterionTitle
        self.theBestResultRows = theBestResultRows
        self.incomparableResultRows = incomparableResultRows
        self.theWorstResultRows = theWorstResultRows
        self.selectedResultRows = selectedResultRows
    }
}

extension AlternativesCellDataConfigurator: Hashable {
    
    static func == (lhs: AlternativesCellDataConfigurator, rhs: AlternativesCellDataConfigurator) -> Bool {
        lhs.iterationTitle == rhs.iterationTitle &&
        lhs.firstCriterionTitle == rhs.firstCriterionTitle &&
        lhs.secondCriterionTitle == rhs.secondCriterionTitle &&
        lhs.thirdCriterionTitle == rhs.thirdCriterionTitle &&
        lhs.fourthCriterionTitle == rhs.fourthCriterionTitle &&
        lhs.theBestResultRows == rhs.theBestResultRows &&
        lhs.incomparableResultRows == rhs.incomparableResultRows &&
        lhs.theWorstResultRows == rhs.theWorstResultRows &&
        lhs.selectedResultRows == rhs.selectedResultRows
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(iterationTitle)
        hasher.combine(firstCriterionTitle)
        hasher.combine(secondCriterionTitle)
        hasher.combine(thirdCriterionTitle)
        hasher.combine(fourthCriterionTitle)
        hasher.combine(theBestResultRows)
        hasher.combine(incomparableResultRows)
        hasher.combine(theWorstResultRows)
        hasher.combine(selectedResultRows)
    }
}

extension AlternativesCellDataConfigurator: TableViewCellConfigurable {
    var identifier: AnyHashable { self }
    
    func registerIdentifier(in tableView: UITableView) {
        tableView.register(
            AlternativesTableViewCell.self,
            forCellReuseIdentifier: AlternativesTableViewCell.identifier
        )
    }
    
    func configureCell(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: AlternativesTableViewCell.identifier,
            for: indexPath
        ) as? AlternativesTableViewCell
        cell?.configure(with: self)
        guard let theBestResultRows = theBestResultRows,
              let incomparableResultRows = incomparableResultRows,
              let theWorstResultRows = theWorstResultRows,
              let selectedResultRows = selectedResultRows else { return UITableViewCell() }
        for theBestResultRow in theBestResultRows {
            if (indexPath.row + 1) == theBestResultRow {
                cell?.backgroundColor = .systemGreen
            }
        }
        for incomparableResultRow in incomparableResultRows {
            if (indexPath.row + 1) == incomparableResultRow {
                cell?.backgroundColor = .systemYellow
            }
        }
        for theWorstResultRow in theWorstResultRows {
            if (indexPath.row + 1) == theWorstResultRow {
                cell?.backgroundColor = .systemRed
            }
        }
        for selectedResultRow in selectedResultRows {
            if (indexPath.row + 1) == selectedResultRow {
                cell?.backgroundColor = .systemBlue
            }
        }
        return cell
    }
}

