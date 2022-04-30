//
//  MainTextFieldTableViewCell.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 26.04.2022.
//

import UIKit

protocol MainTextFieldCellDataRepresentable {
    var title: String { get }
    var placeholder: String { get }
    var text: String { get }
    var keyboardEnter: MainFieldKeyboardEnter { get }
}

class MainTextFieldTableViewCell: UITableViewCell {
    
    typealias TextChangedHandler = (String) -> Void
    
    private var textChangedHandler: TextChangedHandler?
    private var pickerValues: [Int] = []
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 10
        textField.setLeftPaddingPoints(10)
        textField.setRightPaddingPoints(10)
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        return textField
    }()
    
    private var inputPicker = UIPickerView(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pickerValues = []
    }
    
    func configure(with data: MainTextFieldCellDataRepresentable,
                   textChangedHandler: @escaping TextChangedHandler) {
        titleLabel.text = data.title
        inputTextField.placeholder = data.placeholder
        inputTextField.text = data.text
        
        switch data.keyboardEnter {
        case .numpad:
            inputTextField.keyboardType = .numberPad
        case .picker(let values):
            inputTextField.inputView = inputPicker
            pickerValues = values
        }
        
        self.textChangedHandler = textChangedHandler
    }
    
    private func commonInit() {
        setupSubviews()
        setupAutoLayout()
        
        inputPicker.delegate = self
        inputPicker.dataSource = self
    }
    
    private func setupSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(inputTextField)
    }
    
    private func setupAutoLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            inputTextField.heightAnchor.constraint(equalToConstant: 44),
            inputTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            inputTextField.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            inputTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            inputTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22)
        ])
    }
    
    private func updateTextChangedHandler() {
        textChangedHandler?(inputTextField.text ?? "")
    }
    
    @objc private func textFieldEditingChanged() {
        updateTextChangedHandler()
    }
}

extension MainTextFieldTableViewCell: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return String(pickerValues[row])
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        inputTextField.text = String(pickerValues[row])
        updateTextChangedHandler()
    }
}

extension MainTextFieldTableViewCell: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerValues.count
    }
}
