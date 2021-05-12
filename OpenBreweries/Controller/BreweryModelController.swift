//
//  BreweryModelController.swift
//  OpenBreweries
//
//  Created by Chad Rutherford on 5/12/21.
//

import Foundation

class BreweryModelController {

    var breweries = [Brewery]()
    let expectedResponseCodes = Set(200 ... 299)

    func fetchBreweries(completion: @escaping (Result<[Brewery], Error>) -> Void) {
        guard let url = URL(string: "https://api.openbrewerydb.org/breweries") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let response = response as? HTTPURLResponse, self.expectedResponseCodes.contains(response.statusCode) else {
                DispatchQueue.main.async {
                    let error = NSError(domain: "Response Error", code: (response as! HTTPURLResponse).statusCode, userInfo: [:])
                    completion(.failure(error))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    let error = NSError(domain: "Invalid Data", code: 0, userInfo: [:])
                    completion(.failure(error))
                }
                return
            }

            let decoder = JSONDecoder()
            do {
                let results = try decoder.decode(BreweryResults.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(results.breweries))
                }
            } catch let error as NSError {
                DispatchQueue.main.async {
                    print("Failed with decode error: \(error.userInfo)")
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
