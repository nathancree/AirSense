//
//  CityData.swift
//  AirSense
//
//  Created by Nathan Cree on 9/16/23.
//

import Foundation

struct CityDataResponse: Decodable {
    let status: String
    let location: CityData
}

struct CityData: Decodable {
    let city: String
    let state: String
    let country: String
    let location: Coordinates
}

struct Coordinates: Decodable {
    let type: String
    let coordinates: [Double]
}
