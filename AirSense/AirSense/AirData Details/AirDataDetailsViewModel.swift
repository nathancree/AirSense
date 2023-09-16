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
#warning("change from TEMP")
    @Published var airData: AirDataTEMP
    @Published var backgroundColor: Color
    @Published var airQualityMessage: String
#warning("change from TEMP")
    init(airData: AirDataTEMP) {
        self.airData = airData
        if airData.aquis <= 50 {
            self.backgroundColor = Color("GoodAQI")
            self.airQualityMessage = "GOOD"
        } else if airData.aquis <= 100 {
            self.backgroundColor = Color("ModerateAQI")
            self.airQualityMessage = "MODERATE"
        } else if airData.aquis <= 150 {
            self.backgroundColor = Color("SlightlyUnhealthyAQI")
            self.airQualityMessage = "SLIGHTLY UNHEALTHY"
        } else if airData.aquis <= 200 {
            self.backgroundColor = Color("UnhealthyAQI")
            self.airQualityMessage = "UNHEALTHY"
        } else if airData.aquis <= 300 {
            self.backgroundColor = Color("VeryUnhealthyAQI")
            self.airQualityMessage = "VERY UNHEALTHY"
        } else {
            self.backgroundColor = Color("HazardousAQI")
            self.airQualityMessage = "HAZARDOUS"
        }
    }
    
    
}
