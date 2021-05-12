//
//  BreweryListViewController.swift
//  OpenBreweries
//
//  Created by Chad Rutherford on 5/12/21.
//

import UIKit

class BreweryListViewController: UITableViewController {

    let modelController = BreweryModelController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        modelController.fetchBreweries { result in
            switch result {
            case .success(let breweries):
                self.modelController.breweries = breweries
                self.tableView.reloadData()
            case .failure:
                let alert = UIAlertController(title: "Error", message: "Error fetching breweries", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)
            }
        }
    }

    private func configureUI() {
        title = "Breweries"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(BreweryCell.self, forCellReuseIdentifier: BreweryCell.reuseIdentifier)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelController.breweries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BreweryCell.reuseIdentifier, for: indexPath) as? BreweryCell else { return UITableViewCell() }
        cell.brewery = modelController.breweries[indexPath.row]
        return cell
    }
}
