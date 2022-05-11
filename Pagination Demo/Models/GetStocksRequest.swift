//
//  GetStocksRequest.swift
//  Pagination Demo
//
//  Created by Difeng Chen on 5/10/22.
//

import Foundation

struct GetStocksRequest: Encodable {
    let currentCount: Int
    let isPaginating: Bool
}
