//
//  AirDataDetailsView.swift
//  AirSense
//
//  Created by Nathan Cree on 9/15/23.
//

import SwiftUI

struct AirDataDetailsView: View {
    @StateObject var airDetailsVm: AirDataDetailsViewModel
    var body: some View {
        VStack{
            Text(airDetailsVm.airData.city)
            Text(airDetailsVm.airData.state)
            Text(airDetailsVm.airData.country)
            Text("TIMESTAMP: \(airDetailsVm.airData.ts)")
            Text("ICON CODE: \(airDetailsVm.airData.ic)")
            Text("AQI VALUE: \(airDetailsVm.airData.aquis)")
            Text("TEMP: \(airDetailsVm.airData.tp)")
            Text("PRESSURE\(airDetailsVm.airData.pr)")
            Text("HUMIDITY: \(airDetailsVm.airData.hu)")
            Text("WIND SPEED: \(airDetailsVm.airData.ws)")
        }
        
    }
}

struct AirDataDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let airDetailsVm = AirDataDetailsViewModel(airData: AirDataTEMP.example)
        AirDataDetailsView(airDetailsVm: airDetailsVm)
    }
}
