//
//  BreweryCell.swift
//  OpenBreweries
//
//  Created by Chad Rutherford on 5/12/21.
//

import UIKit

protocol ReuseIdentifiable: AnyObject {
    static var reuseIdentifier: String { get }
}

final class BreweryCell: UITableViewCell {

    var brewery: Brewery? {
        didSet {
            updateViews()
        }
    }

    private func updateViews() {
        guard let brewery = brewery else { return }
        textLabel?.text = brewery.name
        detailTextLabel?.text = brewery.address
    }
}

extension BreweryCell: ReuseIdentifiable {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
