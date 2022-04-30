//
//  MainViewController.swift
//  DecisionMaker
//
//  Created by Chernousova Maria on 24.04.2022.
//

import UIKit

class MainViewController: UIViewController {
    enum Section {
        case main
    }
    
    private typealias DataSource = UITableViewDiffableDataSource<Section, MainDecorator>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, MainDecorator>
    
    private lazy var tableView = UITableView(frame: .zero)
    private lazy var dataSource = DataSource(tableView: tableView) {
        $2.configureCell(in: $0, for: $1)
    }
    
    private var viewModel: MainViewModelProvider
    
    init(viewModel: MainViewModelProvider) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupAutoLayout()
        
        bind()
        viewModel.didLoad()
    }
    
    private func bind() {
        viewModel.updateAction = { [weak dataSource] criteria in
            guard let dataSource = dataSource else { return }
            var snapshot = DataSourceSnapshot()
            snapshot.appendSections([.main])
            snapshot.appendItems(criteria, toSection: .main)
            dataSource.apply(snapshot)
        }
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.bounces = false
        dataSource.defaultRowAnimation = .fade
        MainRowComponent.allCases.forEach { $0.dataConfigurable.registerIdentifier(in: tableView) }
        
        view.backgroundColor = .systemBackground
    }
    
    private func setupAutoLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
