//
//  PrimaryButton.swift
//  Pagination Demo
//
//  Created by Difeng Chen on 5/10/22.
//

import UIKit

final class PrimaryButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false

        setTitleColor(.systemCyan, for: .normal)

        layer.cornerRadius = 10
        layer.borderColor = UIColor.systemCyan.cgColor
        layer.borderWidth = 1
    }
}
