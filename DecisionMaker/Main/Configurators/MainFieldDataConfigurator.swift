//
//  MainFieldDataConfigurator.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 28.04.2022.
//

import UIKit

struct MainFieldDataConfigurator: MainTextFieldCellDataRepresentable {

    static let empty = MainFieldDataConfigurator(title: "", placeholder: "", text: "") { _ in }
    
    let title: String
    let placeholder: String
    let text: String
    let keyboardEnter: MainFieldKeyboardEnter
    
    private let textChangedHandler: MainTextFieldTableViewCell.TextChangedHandler
    
    init(
        title: String,
        placeholder: String,
        text: String,
        keyboardEnter: MainFieldKeyboardEnter = .numpad,
        textChangedHandler: @escaping MainTextFieldTableViewCell.TextChangedHandler
    ) {
        self.title = title
        self.placeholder = placeholder
        self.text = text
        self.keyboardEnter = keyboardEnter
        self.textChangedHandler = textChangedHandler
    }
}

extension MainFieldDataConfigurator: Hashable {
    
    static func == (lhs: MainFieldDataConfigurator, rhs: MainFieldDataConfigurator) -> Bool {
        lhs.title == rhs.title &&
        lhs.placeholder == rhs.placeholder &&
        lhs.keyboardEnter == rhs.keyboardEnter
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(placeholder)
        hasher.combine(keyboardEnter)
    }
}

extension MainFieldDataConfigurator: TableViewCellConfigurable {
    
    var identifier: AnyHashable { self }
    
    func registerIdentifier(in tableView: UITableView) {
        tableView.register(
            MainTextFieldTableViewCell.self,
            forCellReuseIdentifier: MainTextFieldTableViewCell.identifier
        )
    }
    
    func configureCell(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MainTextFieldTableViewCell.identifier,
            for: indexPath
        ) as? MainTextFieldTableViewCell
        cell?.configure(with: self, textChangedHandler: textChangedHandler)
        return cell
    }
}
