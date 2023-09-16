//
//  TempViewModel.swift
//  AirSense
//
//  Created by Nathan Cree on 9/15/23.
//

import Foundation
@MainActor
class TempViewModel: ObservableObject {
    private let service = AirQualityService()
//    @Published public var adata: AirData = AirData(city: "", state: "", country: "", location: nil, forecasts: nil, current: nil, history: nil)
//
//    private func setAirData(adata: AirData) {
//        self.adata = adata
//    }
}

extension TempViewModel {
    func getAirData() {
        Task {
            do {
                let adata = try await service.getAirQuality()
//                setAirData(adata: adata)
            } catch {
                print("\(error)")
            }
        }
    }
}
