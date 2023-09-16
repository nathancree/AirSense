//
//  HomeViewModel.swift
//  AirSense
//
//  Created by Nathan Cree on 9/15/23.
//

import Foundation
import SwiftUI
@MainActor
class HomeViewModel: ObservableObject {
    //saves the favorited locations
    let defaults = UserDefaults.standard
    @Published var favAirData: [AirData] = [] {
        didSet {
            print("Called didSet")
            let encoder = JSONEncoder()
            if let encodedAirData = try? encoder.encode(favAirData) {
                defaults.set(encodedAirData, forKey: "favAirData")
            }
        }
    }
    
    
    private let service = AirQualityService()
//    @Published public var adata: AirData = AirData(city: "", state: "", country: "", location: nil, forecasts: nil, current: nil, history: nil)
    
    private func setAirData(adata: AirData) {
//        self.adata = adata
    }
    
#warning("change from TEMP")
    @Published var airData: AirDataTEMP
    @Published var backgroundColor: Color
    @Published var airQualityMessage: String
#warning("change from TEMP")
    init(airData: AirDataTEMP) {
        self.airData = airData
        if airData.aqius <= 50 {
            self.backgroundColor = Color("GoodAQI")
            self.airQualityMessage = "GOOD"
        } else if airData.aqius <= 100 {
            self.backgroundColor = Color("ModerateAQI")
            self.airQualityMessage = "MODERATE"
        } else if airData.aqius <= 150 {
            self.backgroundColor = Color("SlightlyUnhealthyAQI")
            self.airQualityMessage = "SLIGHTLY UNHEALTHY"
        } else if airData.aqius <= 200 {
            self.backgroundColor = Color("UnhealthyAQI")
            self.airQualityMessage = "UNHEALTHY"
        } else if airData.aqius <= 300 {
            self.backgroundColor = Color("VeryUnhealthyAQI")
            self.airQualityMessage = "VERY UNHEALTHY"
        } else {
            self.backgroundColor = Color("HazardousAQI")
            self.airQualityMessage = "HAZARDOUS"
        }
        
        print("Called favAirData default init")
        if let saved = defaults.data(forKey: "favAirData") {
            let decoder = JSONDecoder()
            if let favAirDataList = try? decoder.decode([AirData].self, from: saved) {
                print("Pulled from userdefaults")
                self.favAirData = favAirDataList
            }
        }
    }
}

//uses service to get data on the air from API
extension HomeViewModel {
    func getAirData() {
        Task {
            do {
                let adata = try await service.getAirQuality()
                setAirData(adata: adata)
            } catch {
                print("\(error)")
            }
        }
    }
}

#warning("review all default state code")
// adding and removing functions for the data that gets saved
extension HomeViewModel {
    func addLocation(_ airData: AirData) {
        DispatchQueue.main.async {
            self.favAirData.append(airData)
            self.objectWillChange.send()
        }
    }
    
    func removeLocation(_ airData: AirData) {
        var i: Int = 0
        for element in favAirData {
            if(element.city == airData.city) {
                favAirData.remove(at: i)
                break
            } else {
                i += 1
            }
        }
    }
}
