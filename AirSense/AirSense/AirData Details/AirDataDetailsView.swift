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
        NavigationStack {
            ZStack {
                airDetailsVm.backgroundColor.ignoresSafeArea()
                VStack{
                    Text(airDetailsVm.airData.city)
                        .font(.title)
                        .fontWeight(.semibold)
                    HStack {
                        Text(airDetailsVm.airData.country)
                        Text(airDetailsVm.airData.state)
                    }
                    .padding(.bottom, 10)
                    ZStack {
                        Circle()
                            .stroke(.white, lineWidth: 8)
                            .frame(width:400)
                        VStack {
                            Text("AQI")
                                .font(.title2)
                            Text("\(airDetailsVm.airData.aqius)")
                                .fontWeight(.bold)
                                .font(.system(size: 125))
                            
                        }
                    }
                    
                    HStack {
                        Spacer()
                        NavigationLink {
                            #warning("add forecast view")
                            //links to forecast view
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 120, height: 50)
                                Text("Forecast")
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .foregroundColor(airDetailsVm.backgroundColor)
                            }
                        }
                        .padding(.trailing)
                        .padding(.bottom)
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 50)
                            .ignoresSafeArea()
                        VStack {
                            Text(airDetailsVm.airQualityMessage)
                                .font(.title)
                                .fontWeight(.semibold)
                                .padding(.top, 20)
                            Spacer()
                            HStack (spacing: 50){
                                #warning("add flag and icon image")
                                //country flag on the left
                                Text("PRESSURE: \(airDetailsVm.airData.pr)")
                                //weather icon on the right
                                VStack (alignment: .leading){
                                    Text("TEMP: \(airDetailsVm.airData.tp)")
                                    Text("HUMIDITY: \(airDetailsVm.airData.hu)")
                                }
                            }
                            
                        }
                        .foregroundColor(.black)
                    }
                }
                .foregroundColor(.white)
            }
        }
        
    }
}

struct AirDataDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        #warning("change from temp")
        let airDetailsVm = AirDataDetailsViewModel(airData: AirDataTEMP.example)
        AirDataDetailsView(airDetailsVm: airDetailsVm)
    }
}
