//
//  AirData.swift
//  AirSense
//
//  Created by Nathan Cree on 9/15/23.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation
import SwiftUI

// MARK: - Welcome
struct Response: Codable {
    let status: String
    let data: AirData
}

// MARK: - DataClass
struct AirData: Codable, Identifiable {
    let id = UUID()
    let city, state, country: String?
    let location: Location?
    let forecasts: [Forecast]?
    let current: Current
    let history: History?
}

// MARK: - Current
struct Current: Codable {
    let weather: Weather
    let pollution: Pollution
}

// MARK: - Pollution
struct Pollution: Codable {
    let ts: String
    let aqius: Double
    let mainus: Main
    let aqicn: Double
    let maincn: Main
    let p2: Co?
    let p1: Co?
    let n2, s2, co: Co?
}

// MARK: - Co
struct Co: Codable {
    let conc: Double
    let aqius, aqicn: Double
}

enum Main: String, Codable {
    case p1 = "p1"
    case p2 = "p2"
}

// MARK: - Weather
struct Weather: Codable {
    let ts: String
    let tp, pr, hu, ws: Double
    let wd: Double
    let ic: String
}

// MARK: - Forecast
struct Forecast: Codable {
    let ts: String
    let aqius, aqicn, tp, tpMin: Double
    let pr, hu, ws, wd: Double
    let ic: String

    enum CodingKeys: String, CodingKey {
        case ts, aqius, aqicn, tp
        case tpMin = "tp_min"
        case pr, hu, ws, wd, ic
    }
}

// MARK: - History
struct History: Codable {
    let weather: [Weather]
    let pollution: [Pollution]
}

// MARK: - Location
struct Location: Codable {
    let type: String
    let coordinates: [Double]
}

extension AirData {
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
