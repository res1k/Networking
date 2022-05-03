//
//  NetworkManager.swift
//  Networking
//
//  Created by Andrey Zhivotov on 25.04.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}

    func fetchCurrenciesWithAlamofire(url: String, completion: @escaping(Result<[Currency], Error>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    let currencies = Currencies.getCurrencies(data: data)
                    DispatchQueue.main.async {
                        completion(.success(currencies))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}


