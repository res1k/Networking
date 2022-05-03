//
//  Currency.swift
//  Networking
//
//  Created by Andrey Zhivotov on 25.04.2022.
//

import Foundation

struct Currency: Codable {
    let id: String?
    let name: String?
    
    init(data: [String: Any]) {
        self.id = data["id"] as? String
        self.name = data["name"] as? String
    }
    
    static func getCurrencies(data: Any) -> [Currency] {
        guard let data = data as? [[String: Any]] else { return [] }
        return data.compactMap { Currency(data: $0) }
    }
}

struct Currencies: Codable {
    let data: [Currency]
    
    static func getCurrencies(data: Any) -> [Currency] {
        guard let data = data as? [String: Any],
              let currenciesData = data["data"] else { return [] }
        
        let currencies = Currency.getCurrencies(data: currenciesData)
        
        return currencies
    }
}
