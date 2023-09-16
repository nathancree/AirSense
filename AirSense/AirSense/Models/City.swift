//
//  City.swift
//  AirSense
//
//  Created by Nathan Cree on 9/16/23.
//

import Foundation

struct CityResponse: Codable {
    let status: String
    let data: [City]
}

struct City: Codable, Identifiable {
    let id = UUID()
    let city: String
}
