//
//  MainButtonTableViewCell.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 28.04.2022.
//

import UIKit

protocol MainButtonDataRepresentable {
    var title: String { get }
    var isEnabled: Bool { get }
}

class MainButtonTableViewCell: UITableViewCell {
    
    typealias TapHandler = () -> Void
    
    private var tapHandler: TapHandler?
    
    private lazy var button: UIButton = {
        let button = UIButton(configuration: .filled())
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configure(with data: MainButtonDataRepresentable,
                   tapHandler: @escaping TapHandler) {
        button.setTitle(data.title, for: .normal)
        button.isEnabled = data.isEnabled
        self.tapHandler = tapHandler
    }
    
    private func commonInit() {
        setupSubviews()
        setupAutoLayout()
    }
    
    private func setupSubviews() {
        contentView.addSubview(button)
    }
    
    private func setupAutoLayout() {
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 44),
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22)
        ])
    }
    
    @objc private func buttonTapped() {
        tapHandler?()
    }
}
