//
//  HomeViewModel.swift
//  Pagination Demo
//
//  Created by Difeng Chen on 5/10/22.
//

import Foundation
import FirebaseFunctions

protocol HomeViewModelDelegate: AnyObject {
    func didFinishUpdatingStocks()
    func didUpdateLoadingState(isLoading: Bool)
}

final class HomeViewModel {

    // MARK: - Properties

    private(set) var stocks = [StockResponse]()
    private(set) weak var delegate: HomeViewModelDelegate?

    private var isLoading = false {
        didSet {
            delegate?.didUpdateLoadingState(isLoading: isLoading)
        }
    }

    let sortingOptions: [SortingOption] = [.symbol, .change, .name]

    var selectedSortingOption: SortingOption? {
        didSet {
            switch selectedSortingOption {
            case .change:
                stocks.sort { $0.change < $1.change }
            case .name:
                stocks.sort { $0.name < $1.name }
            case .symbol:
                stocks.sort { $0.symbol < $1.symbol }
            default:
                break
            }

            delegate?.didFinishUpdatingStocks()
        }
    }

    // MARK: - Initializers

    init(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
    }

    // MARK: - Functions

    func loadStocks(isPaginating: Bool = false) {
        guard !isLoading else { return }

        let request = GetStocksRequest(currentCount: stocks.count, isPaginating: isPaginating)

        guard let data = try? JSONEncoder().encode(request), let paramaters = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { return }

        isLoading = true

        Functions.functions().httpsCallable("getStocks").call(paramaters) { [weak self] result, error in
            self?.isLoading = false

            let object = result?.data as? [Any]

            if let object = object, let data = try? JSONSerialization.data(withJSONObject: object) {
                guard let stocks = try? JSONDecoder().decode([StockResponse].self, from: data) else { return }

                if !isPaginating {
                    self?.stocks = stocks
                } else {
                    self?.stocks.append(contentsOf: stocks)
                }

                self?.delegate?.didFinishUpdatingStocks()
            }
        }
    }
}
