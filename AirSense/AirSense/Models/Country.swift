//
//  Country.swift
//  AirSense
//
//  Created by Nathan Cree on 9/16/23.
//

import Foundation

struct CountryResponse: Codable {
    let status: String
    let country: [Country]
}

// MARK: - Country
struct Country: Codable {
    let state: String
}
