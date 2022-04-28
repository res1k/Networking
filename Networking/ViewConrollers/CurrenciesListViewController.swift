//
//  CurrenciesListViewController.swift
//  Networking
//
//  Created by Andrey Zhivotov on 25.04.2022.
//

import UIKit

class CurrenciesListViewController: UITableViewController {

    private let linkAPI = "https://api.coinbase.com/v2/currencies"
    
    private var currenciesInfo: Currencies?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(from: linkAPI)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currenciesInfo?.data.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
       
        content.text = currenciesInfo?.data[indexPath.row].id
        content.secondaryText = currenciesInfo?.data[indexPath.row].name
        
        cell.contentConfiguration = content

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension CurrenciesListViewController {
    
    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchData(from: url) { currenciesInfo in
            self.currenciesInfo = currenciesInfo
            self.tableView.reloadData()
        }
    }
    
}
