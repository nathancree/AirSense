//
//  Country.swift
//  AirSense
//
//  Created by Nathan Cree on 9/16/23.
//

import Foundation

struct CountryResponse: Codable {
    let status: String
    let data: [Country] //[String: Country]
}

// MARK: - Country
struct Country: Codable, Identifiable {
    let id = UUID()
    let country: String
}


//struct CountryLst: Codable {
//    let dict: [String: Country]
//}



//struct CountryResponse: Codable {
//    let results: [Country]
//    let status: String
//}
//
//struct Country: Codable, Identifiable {
//    let id = UUID()
//    let name: String
//}
