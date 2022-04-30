//
//  SettingsViewModel.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 24.04.2022.
//

import Foundation

class SettingsViewModel: MainViewModelProvider {
    
    private enum Alternative: CaseIterable {
        case best
        case incomparable
        case worst
        
        var title: String {
            switch self {
            case .best:
                return "The Best:"
            case .incomparable:
                return "Incomparable:"
            case .worst:
                return "The Worst:"
            }
        }
        
        var placeholder: String {
            "Enter number"
        }
    }
    
    var updateAction: (([MainDecorator]) -> Void) = { _ in }
    
    private let coordinator: SettingsCoordinatorProvider
    private let inputData: DecisionMakerInputData?
    
    private var alternativeValues: [Alternative: Int] = [:]
    
    private var isFirstEnter: Bool {
        alternativeValues.isEmpty
    }
    
    private var isButtonEnabled: Bool {
        Alternative.allCases.count == alternativeValues.count
    }
    
    init(coordinator: SettingsCoordinatorProvider, inputData: DecisionMakerInputData) {
        self.coordinator = coordinator
        self.inputData = inputData
    }
    
    func didLoad() {
        triggerUpdateAction()
    }
    
    private func triggerUpdateAction() {
        var mainDecorators = Alternative.allCases.map { alternative in
            MainDecorator(
                .field(
                    MainFieldDataConfigurator(
                        title: alternative.title,
                        placeholder: alternative.placeholder,
                        text: {
                            if let alternativeValue = alternativeValues[alternative] {
                                return String(alternativeValue)
                            }
                            return ""
                        }(),
                        keyboardEnter: .picker(configurePickerValues(for: alternative))
                    ) { [weak self] number in
                        self?.set(Int(number), for: alternative)
                    }
                )
            )
        }
        mainDecorators.append(
            MainDecorator(
                .button(
                    MainButtonDataConfigurator(
                        title: "Next",
                        isEnabled: isButtonEnabled
                    ) { [weak self] in
                        self?.didSelectNextButton()
                    }
                )
            )
        )
        updateAction(mainDecorators)
    }
    
    private func configurePickerValues(for alternative: Alternative) -> [Int] {
        guard let inputData = inputData else { return [] }
        let endIndex = inputData.firstCriterion * inputData.secondCriterion * inputData.thirdCriterion * inputData.fourthCriterion

        switch alternative {
        case .best:
            if let incomparableValue = alternativeValues[.incomparable] {
                return (1..<incomparableValue).map { $0 }
            } else if let worstValue = alternativeValues[.worst] {
                return (1..<worstValue - 1).map { $0 }
            } else if let incomparableValue = alternativeValues[.incomparable],
                      alternativeValues[.worst] != nil {
                return (1..<incomparableValue).map { $0 }
            }
            return (1..<(endIndex - 1)).map { $0 }
        case .incomparable:
            if let bestValue = alternativeValues[.best] {
                return ((bestValue + 1)...(endIndex - 1)).map { $0 }
            } else if let worstValue = alternativeValues[.worst] {
                return (2..<worstValue).map { $0 }
            } else if let bestValue = alternativeValues[.best],
                      let worstValue = alternativeValues[.worst] {
                return ((bestValue + 1)...(worstValue - 1)).map { $0 }
            }
            return (2..<endIndex).map { $0 }
        case .worst:
            if alternativeValues[.best] != nil,
                let incomparableValue = alternativeValues[.incomparable] {
                return ((incomparableValue + 1)...endIndex).map { $0 }
            } else if let bestValue = alternativeValues[.best] {
                return ((bestValue + 1)...endIndex).map { $0 }
            } else if let incomparableValue = alternativeValues[.incomparable] {
                return ((incomparableValue + 1)...endIndex).map { $0 }
            }
            return (3...endIndex).map { $0 }
        }
    }
    
    private func set(_ value: Int?, for alternative: Alternative) {
        alternativeValues[alternative] = value
        triggerUpdateAction()
    }
    
    private func configureSettings() -> Settings? {
        guard let bestAlternative = alternativeValues[.best],
              let incomparableAlternative = alternativeValues[.incomparable],
              let worstAlternative = alternativeValues[.worst],
              let inputData = inputData else { return nil }
         return Settings(
            inputData: inputData,
            theBestAlternative: bestAlternative,
            incomparableAlternative: incomparableAlternative,
            theWorstAlternative: worstAlternative
         )
    }
    
    private func didSelectNextButton() {
        guard let settings = configureSettings() else { return }
        coordinator.openAlternativesScreen(with: settings)
    }
}
