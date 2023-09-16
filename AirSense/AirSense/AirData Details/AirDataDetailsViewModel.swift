//
//  AirDataDetailsViewModel.swift
//  AirSense
//
//  Created by Nathan Cree on 9/15/23.
//

import Foundation
import SwiftUI
@MainActor
class AirDataDetailsViewModel: ObservableObject {
    @Published var airData: AirData
    @Published var backgroundColor: Color
    @Published var airQualityMessage: String
    init(airData: AirData) {
        self.airData = airData
        if airData.current.pollution.aqius <= 50 {
            self.backgroundColor = .green //Color.goodAQI
            self.airQualityMessage = "GOOD"
        } else if airData.current.pollution.aqius <= 100 {
            self.backgroundColor = .yellow //.moderateAQI
            self.airQualityMessage = "MODERATE"
        } else if airData.current.pollution.aqius <= 150 {
            self.backgroundColor = .orange//.sUnhealthyAQI
            self.airQualityMessage = "SLIGHTLY UNHEALTHY"
        } else if airData.current.pollution.aqius <= 200 {
            self.backgroundColor = .red//.unhealthyAQI
            self.airQualityMessage = "UNHEALTHY"
        } else if airData.current.pollution.aqius <= 300 {
            self.backgroundColor = .purple//.vUnhealthyAQI
            self.airQualityMessage = "VERY UNHEALTHY"
        } else {
            self.backgroundColor = .black//.hazardousAQI
            self.airQualityMessage = "HAZARDOUS"
        }
    }
    
    
}
