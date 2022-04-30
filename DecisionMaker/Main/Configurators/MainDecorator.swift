//
//  MainDecorator.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 28.04.2022.
//

import UIKit

protocol TableViewCellConfigurable {
    var identifier: AnyHashable { get }
    
    func registerIdentifier(in tableView: UITableView)
    func configureCell(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell?
}

struct MainDecorator: TableViewCellConfigurable {

    var identifier: AnyHashable {
        cellConfigurable.identifier
    }
    
    private let cellConfigurable: TableViewCellConfigurable
    
    init(_ rowComponent: MainRowComponent) {
        self.cellConfigurable = rowComponent.dataConfigurable
    }
    
    func registerIdentifier(in tableView: UITableView) {
        cellConfigurable.registerIdentifier(in: tableView)
    }
    
    func configureCell(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell? {
        cellConfigurable.configureCell(in: tableView, for: indexPath)
    }
}

extension MainDecorator: Hashable {

    static func == (lhs: MainDecorator, rhs: MainDecorator) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
