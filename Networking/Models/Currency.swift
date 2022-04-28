//
//  Currency.swift
//  Networking
//
//  Created by Andrey Zhivotov on 25.04.2022.
//

import Foundation

struct Currency: Decodable {
    let id: String?
    let name: String?
}

struct Currencies: Decodable {
    let data: [Currency]
}
