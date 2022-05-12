//
//  StockTableViewCell.swift
//  Pagination Demo
//
//  Created by Difeng Chen on 5/10/22.
//

import UIKit

final class StockTableViewCell: UITableViewCell {

    // MARK: - Views

    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [indexLabel, infoStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var infoStackView: UIStackView = {
        let stackViewe = UIStackView(arrangedSubviews: [symbolLabel, changeLabel, nameLabel])
        stackViewe.translatesAutoresizingMaskIntoConstraints = false
        stackViewe.axis = .vertical
        stackViewe.spacing = 8
        return stackViewe
    }()

    private lazy var indexLabel: BodyLabel = {
        let label = BodyLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var symbolLabel: TitleLabel = {
        let label = TitleLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()

    private lazy var changeLabel: BodyLabel = {
        let label = BodyLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nameLabel: BodyLabel = {
        let label = BodyLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


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
        addSubview(containerStackView)

        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),

            indexLabel.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    func configure(with stock: StockResponse.Stock, index: Int) {
        indexLabel.text = String(index + 1)
        nameLabel.text = stock.name
        changeLabel.text = stock.change
        symbolLabel.text = stock.symbol
    }
}
