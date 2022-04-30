//
//  AlternativesDataConfigurator.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 29.04.2022.
//

import UIKit

class AlternativesDataConfigurator: AlternativesTableViewCellDataRepresentable {
    
    static let empty = AlternativesDataConfigurator(
        iterationTitle: "",
        firstCriterionTitle: "",
        secondCriterionTitle: "",
        thirdCriterionTitle: "",
        fourthCriterionTitle: ""
    )
    
    let iterationTitle: String
    let firstCriterionTitle: String
    let secondCriterionTitle: String
    let thirdCriterionTitle: String
    let fourthCriterionTitle: String
    
    init(
        iterationTitle: String,
        firstCriterionTitle: String,
        secondCriterionTitle: String,
        thirdCriterionTitle: String,
        fourthCriterionTitle: String
    ) {
        self.iterationTitle = iterationTitle
        self.firstCriterionTitle = firstCriterionTitle
        self.secondCriterionTitle = secondCriterionTitle
        self.thirdCriterionTitle = thirdCriterionTitle
        self.fourthCriterionTitle = fourthCriterionTitle
    }
}

extension AlternativesDataConfigurator: Hashable {
    
    static func == (lhs: AlternativesDataConfigurator, rhs: AlternativesDataConfigurator) -> Bool {
        lhs.iterationTitle == rhs.iterationTitle &&
        lhs.firstCriterionTitle == rhs.firstCriterionTitle &&
        lhs.secondCriterionTitle == rhs.secondCriterionTitle &&
        lhs.thirdCriterionTitle == rhs.thirdCriterionTitle &&
        lhs.fourthCriterionTitle == lhs.fourthCriterionTitle
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(iterationTitle)
        hasher.combine(firstCriterionTitle)
        hasher.combine(secondCriterionTitle)
        hasher.combine(thirdCriterionTitle)
        hasher.combine(fourthCriterionTitle)
    }
}

extension AlternativesDataConfigurator: TableViewCellConfigurable {
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
        return cell
    }
}
