//
//  MainViewModel.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 24.04.2022.
//

import Foundation

protocol MainViewModelProvider {
    var updateAction: ([MainDecorator]) -> Void { get set }
    
    func didLoad()
}

class MainViewModel: MainViewModelProvider {
    
    var updateAction: ([MainDecorator]) -> Void = { _ in }
    
    private let coordinator: MainCoordinatorProvider
    private let service = DecisionMakingService()
    
    private var firstCriterion: Int? {
        didSet {
            triggerUpdateAction()
        }
    }
    
    private var secondCriterion: Int? {
        didSet {
            triggerUpdateAction()
        }
    }
    
    private var thirdCriterion: Int? {
        didSet {
            triggerUpdateAction()
        }
    }
    
    private var fourthCriterion: Int? {
        didSet {
            triggerUpdateAction()
        }
    }
    
    private var areButtonsEnabled: Bool {
        firstCriterion != nil &&
        secondCriterion != nil &&
        thirdCriterion != nil &&
        fourthCriterion != nil
    }
    
    init(coordinator: MainCoordinatorProvider) {
        self.coordinator = coordinator
    }
    
    func didLoad() {
        triggerUpdateAction()
    }
    
    private func triggerUpdateAction() {
        updateAction([
            MainDecorator(
                .field(
                    MainFieldDataConfigurator(
                        title: "Criterion 1:",
                        placeholder: "Enter number",
                        text: {
                            if let firstCriterion = firstCriterion {
                                return String(firstCriterion)
                            }
                            return ""
                        }()
                    ) { [weak self] number in
                        self?.firstCriterion = Int(number)
                    }
                )
            ),
            MainDecorator(
                .field(
                    MainFieldDataConfigurator(
                        title: "Criterion 2:",
                        placeholder: "Enter number",
                        text: {
                            if let secondCriterion = secondCriterion {
                                return String(secondCriterion)
                            }
                            return ""
                        }()
                    ) { [weak self] number in
                        self?.secondCriterion = Int(number)
                    }
                )
            ),
            MainDecorator(
                .field(
                    MainFieldDataConfigurator(
                        title: "Criterion 3:",
                        placeholder: "Enter number",
                        text: {
                            if let thirdCriterion = thirdCriterion {
                                return String(thirdCriterion)
                            }
                            return ""
                        }()
                    ) { [weak self] number in
                        self?.thirdCriterion = Int(number)
                    }
                )
            ),
            MainDecorator(
                .field(
                    MainFieldDataConfigurator(
                        title: "Criterion 4:",
                        placeholder: "Enter number",
                        text: {
                            if let fourthCriterion = fourthCriterion {
                                return String(fourthCriterion)
                            }
                            return ""
                        }()
                    ) { [weak self] number in
                        self?.fourthCriterion = Int(number)
                    }
                )
            ),
            MainDecorator(
                .button(
                    MainButtonDataConfigurator(
                        title: "Settings",
                        isEnabled: areButtonsEnabled
                    ) { [weak self] in
                        self?.didSelectSettingsButton()
                    }
                )
            ),
            MainDecorator(
                .button(
                    MainButtonDataConfigurator(
                        title: "Next",
                        isEnabled: areButtonsEnabled
                    ) { [weak self] in
                        self?.didSelectNextButton()
                    }
                )
            )
        ])
    }
    
    private func configureCriteria() -> Criteria? {
        guard let firstCriterion = firstCriterion,
              let secondCriteria = secondCriterion,
              let thirdCriteria = thirdCriterion,
              let fourthCriteria = fourthCriterion else {
            return nil
        }
        return Criteria(
            firstCriterion: firstCriterion,
            secondCriterion: secondCriteria,
            thirdCriterion: thirdCriteria,
            fourthCriterion: fourthCriteria
        )
    }
    
    private func didSelectSettingsButton() {
        guard let criteria = configureCriteria() else { return }
        coordinator.openSettingsScreen(with: criteria)
    }
    
    private func didSelectNextButton() {
        guard let criteria = configureCriteria() else { return }
        coordinator.openAlternativesScreen(with: criteria)
        service.getDecision(from: criteria)
    }
}



