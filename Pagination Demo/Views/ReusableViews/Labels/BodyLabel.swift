//
//  BodyLabel.swift
//  Pagination Demo
//
//  Created by Difeng Chen on 5/11/22.
//

import UIKit

final class BodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        textColor = .lightGray
    }
}
