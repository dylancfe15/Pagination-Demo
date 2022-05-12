//
//  Stock.swift
//  Pagination Demo
//
//  Created by Difeng Chen on 5/10/22.
//

import Foundation

struct StockResponse: Decodable {
    struct Stock: Decodable {
        let change: String
        let country: String
        let industry: String?
        let ipoYear: String?
        let lastSale: String?
        let marketCap: String?
        let name: String
        let netChange: String?
        let sector: String?
        let symbol: String
        let volume: String?
    }

    let stocks: [Stock]
    let total: Int
}
