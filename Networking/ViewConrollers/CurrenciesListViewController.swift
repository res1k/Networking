//
//  CurrenciesListViewController.swift
//  Networking
//
//  Created by Andrey Zhivotov on 25.04.2022.
//

import UIKit

class CurrenciesListViewController: UITableViewController {

    private var currencies: [Currency] = []
    
    private var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner(in: view)
        fetchCurrenciesData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
       
        content.text = currencies[indexPath.row].id
        content.secondaryText = currencies[indexPath.row].name
        
        cell.contentConfiguration = content

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension CurrenciesListViewController {
    
    private func fetchCurrenciesData() {
       
        let json = "https://api.coinbase.com/v2/currencies"
       
        NetworkManager.shared.fetchCurrenciesWithAlamofire(url: json) { result in
            switch result {
            case .success(let currencies):
                self.currencies = currencies
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
}
