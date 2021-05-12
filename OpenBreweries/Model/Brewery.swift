//
//  Brewery.swift
//  OpenBreweries
//
//  Created by Chad Rutherford on 5/12/21.
//

import Foundation

struct Brewery: Codable {
    let name: String
    let street: String?
    let address2: String?
    let address3: String?
    let city: String
    let state: String

    var address: String {
        return "\(street ?? "") \(address2 ?? "") \(address3 ?? "") \(city), \(state)"
    }

    enum BreweryKeys: String, CodingKey {
        case name, street, city, state
        case address2 = "address_2"
        case address3 = "address_3"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BreweryKeys.self)
        name = try container.decode(String.self, forKey: .name)
        street = try container.decodeIfPresent(String.self, forKey: .street)
        address2 = try container.decodeIfPresent(String.self, forKey: .address2)
        address3 = try container.decodeIfPresent(String.self, forKey: .address3)
        city = try container.decode(String.self, forKey: .city)
        state = try container.decode(String.self, forKey: .state)
    }
}
