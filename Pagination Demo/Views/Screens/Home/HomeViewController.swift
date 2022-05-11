//
//  ViewController.swift
//  Pagination Demo
//
//  Created by Difeng Chen on 5/10/22.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - Views

    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sortedByLabel, sortedOptionsStackView, stocksLabel, tableView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private lazy var sortedByLabel: TitleLabel = {
        let label = TitleLabel()
        label.text = "Sorted by:"
        return label
    }()

    private lazy var sortedOptionButtons: [PrimaryButton] = {
        viewModel.sortingOptions.map { option in
            let button = PrimaryButton()
            button.setTitle(option, for: .normal)
            button.addAction(UIAction(handler: { _ in
                self.viewModel.selectedSortingOption = option
                self.sortedByLabel.text = "Sorted by: \(option)"
            }), for: .touchUpInside)
            return button
        }
    }()

    private lazy var sortedOptionsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: sortedOptionButtons)
        stackView.distribution = .fillEqually
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return stackView
    }()

    private lazy var stocksLabel: TitleLabel = {
        let label = TitleLabel()
        label.text = "Stocks:"
        return label
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StockTableViewCell.self, forCellReuseIdentifier: StockTableViewCell.reusableIdentifier)
        return tableView
    }()

    // MARK: - Properties

    private lazy var viewModel = HomeViewModel(delegate: self)


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.loadStocks()

        configure()
    }

    // MARK: - Functions

    private func configure() {
        view.addSubview(containerStackView)

        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - HomeViewController+UITableViewDelegate

extension HomeViewController: UITableViewDelegate {

}

// MARK: - HomeViewController+UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.stocks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.reusableIdentifier, for: indexPath) as? StockTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(with: viewModel.stocks[indexPath.row])

        return cell
    }
}

// MARK: - HomeViewController+HomeViewModelDelegate

extension HomeViewController: HomeViewModelDelegate {
    func didFinishLoadingStocks() {
        tableView.reloadData()
    }
}
