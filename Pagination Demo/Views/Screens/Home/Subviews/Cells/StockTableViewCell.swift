//
//  StockTableViewCell.swift
//  Pagination Demo
//
//  Created by Difeng Chen on 5/10/22.
//

import UIKit

final class StockTableViewCell: UITableViewCell {

    // MARK: - Properties

    static var reusableIdentifier: String {
        String(describing: type(of: self))
    }

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    private func configureUI() {

    }

    func configure(with stock: StockResponse) {
        
    }
}
