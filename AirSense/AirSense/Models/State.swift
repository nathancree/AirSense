//
//  State.swift
//  AirSense
//
//  Created by Nathan Cree on 9/16/23.
//

import Foundation

struct StateResponse: Codable {
    let status: String
    let state: [State]
}

// MARK: - State
struct State: Codable {
    let city: String
}
