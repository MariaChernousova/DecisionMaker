//
//  AlternativesTableViewCell.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 28.04.2022.
//

import UIKit

protocol AlternativesTableViewCellDataRepresentable {
    var iterationTitle: String { get }
    var firstCriterionTitle: String { get }
    var secondCriterionTitle: String { get }
    var thirdCriterionTitle: String { get }
    var fourthCriterionTitle: String { get }
}

class AlternativesTableViewCell: UITableViewCell {
    
    private lazy var iterationLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var firstCriterionResultLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var secondCriterionResultLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var thirdCriterionResultLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var fourthCriterionResultLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            iterationLabel,
            firstCriterionResultLabel,
            secondCriterionResultLabel,
            thirdCriterionResultLabel,
            fourthCriterionResultLabel
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configure(with data: AlternativesTableViewCellDataRepresentable) {
        iterationLabel.text = data.iterationTitle
        firstCriterionResultLabel.text = data.firstCriterionTitle
        secondCriterionResultLabel.text = data.secondCriterionTitle
        thirdCriterionResultLabel.text = data.thirdCriterionTitle
        fourthCriterionResultLabel.text = data.fourthCriterionTitle
    }
    
    private func commonInit() {
        setupSubviews()
        setupAutoLayout()
    }
    
    private func setupSubviews() {
        contentView.addSubview(stackView)
    }
    
    private func setupAutoLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
