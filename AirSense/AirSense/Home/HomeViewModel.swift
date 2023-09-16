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
    
    private func setAirData(adata: AirData) {
        self.airData = adata
    }
    
    @Published var airData: AirData = AirData.inital

    init() {
        getAirData()
        
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

extension HomeViewModel {
    func getbackgroundColor(airData: AirData) -> Color {
        if airData.current.pollution.aqius <= 50 {
            return .green//.goodAQI
        } else if airData.current.pollution.aqius <= 100 {
            return .yellow//.moderateAQI
        } else if airData.current.pollution.aqius <= 150 {
            return .orange//.sUnhealthyAQI
        } else if airData.current.pollution.aqius <= 200 {
            return .red//.unhealthyAQI
        } else if airData.current.pollution.aqius <= 300 {
            return .purple//.vUnhealthyAQI
        } else {
            return .black//.hazardousAQI
        }
    }
    
    func getAirQualityMessage(airData: AirData) -> String {
        if airData.current.pollution.aqius <= 50 {
            return "GOOD"
        } else if airData.current.pollution.aqius <= 100 {
            return "MODERATE"
        } else if airData.current.pollution.aqius <= 150 {
            return "SLIGHTLY UNHEALTHY"
        } else if airData.current.pollution.aqius <= 200 {
            return "UNHEALTHY"
        } else if airData.current.pollution.aqius <= 300 {
            return "VERY UNHEALTHY"
        } else {
            return "HAZARDOUS"
        }
    }
}

#warning("review all default state code")
// adding and removing functions for the data that gets saved
extension HomeViewModel {
    func addLocation(_ airData: AirData) async throws{
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
    
    //debuggin
    func printFavData() {
        print(favAirData)
    }
}
