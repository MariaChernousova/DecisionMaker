//
//  MainButtonDataConfigurator.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 28.04.2022.
//

import UIKit

struct MainButtonDataConfigurator: MainButtonDataRepresentable {

    static let empty = MainButtonDataConfigurator(title: "", isEnabled: true) { }
    
    let title: String
    let isEnabled: Bool
    let tapHandler: MainButtonTableViewCell.TapHandler
}

extension MainButtonDataConfigurator: Hashable {
    static func == (lhs: MainButtonDataConfigurator, rhs: MainButtonDataConfigurator) -> Bool {
        lhs.title == rhs.title && lhs.isEnabled == rhs.isEnabled
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(isEnabled)
    }
}

extension MainButtonDataConfigurator: TableViewCellConfigurable {
    
    var identifier: AnyHashable { self }
    
    func registerIdentifier(in tableView: UITableView) {
        tableView.register(
            MainButtonTableViewCell.self,
            forCellReuseIdentifier: MainButtonTableViewCell.identifier
        )
    }
    
    func configureCell(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MainButtonTableViewCell.identifier,
            for: indexPath
        ) as? MainButtonTableViewCell
        cell?.configure(with: self, tapHandler: tapHandler)
        return cell
    }
}
