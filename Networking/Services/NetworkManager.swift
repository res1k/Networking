//
//  NetworkManager.swift
//  Networking
//
//  Created by Andrey Zhivotov on 25.04.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: String?, with completion: @escaping(Currencies) -> Void) {
        guard let urlAPI = url else { return }
        guard let url = URL(string: urlAPI) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let currenciesInfo = try JSONDecoder().decode(Currencies.self, from: data)
                DispatchQueue.main.async {
                    completion(currenciesInfo)
                }
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
}


