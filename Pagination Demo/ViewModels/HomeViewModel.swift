//
//  HomeViewModel.swift
//  Pagination Demo
//
//  Created by Difeng Chen on 5/10/22.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didFinishLoadingStocks()
}

final class HomeViewModel {

    // MARK: - Properties

    private(set) var stocks = [StockResponse]()
    private(set) weak var delegate: HomeViewModelDelegate?

    private var isLoading = false

    let sortingOptions = ["change", "name", "symbol"]

    var selectedSortingOption: String? {
        didSet {
            loadStocks(sortedBy: selectedSortingOption)
        }
    }

    // MARK: - Initializers

    init(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
    }

    // MARK: - Functions

    func loadStocks(sortedBy: String? = nil, isPaginating: Bool = false) {
        guard let url = URL(string: "https://us-central1-pagination-demo-3e397.cloudfunctions.net/getStocks"), !isLoading else { return }

        let request = GetStocksRequest(currentCount: stocks.count, sortedBy: sortedBy)

        var urlRequest = URLRequest(url: url)

        do {
            urlRequest.httpBody = try JSONEncoder().encode(request)
        } catch {
            print(error)
        }

        isLoading = true

        URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            self?.isLoading = false

            guard let data = data else { return }

            do {
                let stocks = try JSONDecoder().decode([StockResponse].self, from: data)

                if !isPaginating {
                    self?.stocks = stocks
                } else {
                    self?.stocks.append(contentsOf: stocks)
                }
                self?.delegate?.didFinishLoadingStocks()
            } catch {
                print(error)
            }
        }.resume()
    }
}
