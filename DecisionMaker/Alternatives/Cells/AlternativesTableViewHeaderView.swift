//
//  AlternativesTableViewHeaderView.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 01.05.2022.
//

import UIKit

protocol AlternativesTableViewResultCellDataRepresentable {
    var theBestResultRows: [Int] { get }
    var theWorstResultRows: [Int] { get }
    var incomparableResultRows: [Int] { get }
}

class AlternativesTableViewResultCell: UITableViewCell {
    
    private lazy var theBestLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: .current)
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var theWorstLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: .current)
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var incomparableLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: .current)
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var sumLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: .current)
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            theBestLabel,
            theWorstLabel,
            incomparableLabel,
            sumLabel
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

    func configure(with data: AlternativesTableViewResultCellDataRepresentable) {
        let theBestResults = data.theBestResultRows.count
        let theWorstResults = data.theWorstResultRows.count
        let incomparableResults = data.incomparableResultRows.count
        let sum = theBestResults + theWorstResults + incomparableResults
        
        theBestLabel.text = "The best: \(theBestResults)"
        theWorstLabel.text = "The worst: \(theWorstResults)"
        incomparableLabel.text = "Incomparable: \(incomparableResults)"
        sumLabel.text = "Sum: \(sum)"
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
