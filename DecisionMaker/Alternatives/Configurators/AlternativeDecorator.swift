//
//  AlternativeDecorator.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 29.04.2022.
//

import UIKit

protocol AlternativeTableViewCellConfigurable {
    var identifier: AnyHashable { get }
    
    func registerIdentifier(in tableView: UITableView)
    func configureCell(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell?
}

struct AlternativeDecorator: TableViewCellConfigurable {
    
    var identifier: AnyHashable {
        cellConfigurable.identifier
    }
    
    private let cellConfigurable: TableViewCellConfigurable
    
    init(_ rowComponent: AlternativeRowComponent) {
        self.cellConfigurable = rowComponent.dataConfigurable
    }
    
    func registerIdentifier(in tableView: UITableView) {
        cellConfigurable.registerIdentifier(in: tableView)
    }
    
    func configureCell(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell? {
        cellConfigurable.configureCell(in: tableView, for: indexPath)
    }
}

extension AlternativeDecorator: Hashable {
    
    static func == (lhs: AlternativeDecorator, rhs: AlternativeDecorator) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
