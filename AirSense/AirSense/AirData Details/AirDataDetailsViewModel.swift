//
//  AirDataDetailsViewModel.swift
//  AirSense
//
//  Created by Nathan Cree on 9/15/23.
//

import Foundation
@MainActor
class AirDataDetailsViewModel: ObservableObject {
#warning("change from TEMP")
    @Published var airData: AirDataTEMP
    
#warning("change from TEMP")
    init(airData: AirDataTEMP) {
        self.airData = airData
    }
}
