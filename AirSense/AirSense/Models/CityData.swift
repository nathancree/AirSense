//
//  CityData.swift
//  AirSense
//
//  Created by Nathan Cree on 9/16/23.
//

import Foundation

//struct CityDataResponse: Decodable {
//    let status: String
//    let location: CityData
//}
//
//struct CityData: Decodable {
//    let city: String
//    let state: String
//    let country: String
//    let location: Coordinates
//}
//
//struct Coordinates: Decodable {
//    let type: String
//    let coordinates: [Double]
//}

// MARK: - Welcome
struct CityDataResponse: Codable {
    let status: String
    let data: CityData
}

// MARK: - DataClass
struct CityData: Codable {
    let city, state, country: String
    let location: Location1
//    let current: Current?
}

//// MARK: - Current
//struct Current: Codable {
//    let pollution: Pollution
//    let weather: Weather
//}
//
//// MARK: - Pollution
//struct Pollution: Codable {
//    let ts: String
//    let aqius: Int
//    let mainus: String
//    let aqicn: Int
//    let maincn: String
//}
//
//// MARK: - Weather
//struct Weather: Codable {
//    let ts: String
//    let tp, pr, hu: Int
//    let ws: Double
//    let wd: Int
//    let ic: String
//}
//
//// MARK: - Location
struct Location1: Codable {
    let type: String
    let coordinates: [Double]
}
//
