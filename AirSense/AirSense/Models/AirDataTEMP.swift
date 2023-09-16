//
//  AirDataTEMP.swift
//  AirSense
//
//  Created by Nathan Cree on 9/15/23.
//

import Foundation
struct AirDataTEMP {
    let city, state, country, ts, ic: String
    let aqius, tp, pr, hu, ws, wd: Int
}

extension AirDataTEMP {
    static var example: AirDataTEMP {
        AirDataTEMP(city: "Arden", state: "NC", country: "USA", ts: "2017-02-01T01:00:00.000Z", ic: "01n", aqius: 321, tp: 8, pr: 976, hu: 100, ws: 3, wd: 313)
    }
}
