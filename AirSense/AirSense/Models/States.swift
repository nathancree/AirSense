//
//  State.swift
//  AirSense
//
//  Created by Nathan Cree on 9/16/23.
//

import Foundation

struct StateResponse: Codable {
    let status: String
    let data: [States]
}

// MARK: - State
struct States: Codable, Identifiable {
    let id = UUID()
    let state: String
}
