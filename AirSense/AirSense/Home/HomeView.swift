//
//  HomeView.swift
//  AirSense
//
//  Created by Nathan Cree on 9/15/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homevm = HomeViewModel(airData: AirDataTEMP.example)
    var body: some View {
        ZStack {
            HomeDetailSubview(vm: homevm)
        }
        .foregroundColor(.white)
        
        
    }
    
    private var favoriteList: some View {
        ScrollView(showsIndicators: false) {
            ForEach(homevm.favAirData) { airData in
                #warning("change from temp")
                NavigationLink {
                    AirDataDetailsView(airDetailsVm: AirDataDetailsViewModel(airData: AirDataTEMP.example))
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(getbackgroundColor(airData: airData))
                        HStack {
                            //flag
                            
                            Text("\(airData.city ?? ""), ")
                            Text("\(airData.state ?? ""), ")
                            Text("\(airData.country ?? "")")
                            
                            Text("\(airData.current.pollution.aqius)")
                                .fontWeight(.bold)
                                .font(.title)
                        }
                        .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

struct HomeDetailSubview: View {
    let vm: HomeViewModel
    var body: some View {
        NavigationStack {
            ZStack {
                vm.backgroundColor.ignoresSafeArea()
                VStack{
                    Text(vm.airData.city)
                        .font(.title2)
                        .fontWeight(.semibold)
                    HStack {
                        Text(vm.airData.country)
                        Text(vm.airData.state)
                    }
                    .padding(.bottom, 10)
                    ZStack {
                        Circle()
                            .stroke(.white, lineWidth: 8)
                        VStack {
                            Text("AQI")
                                .font(.title2)
                            Text("\(vm.airData.aqius)")
                                .fontWeight(.bold)
                                .font(.system(size: 75))
                            
                        }
                    }
                    
                    HStack {
                        NavigationLink {
                            #warning("change from temp")
                            AirDataDetailsView(airDetailsVm: AirDataDetailsViewModel(airData: AirDataTEMP.example))
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 120, height: 50)
                                Text("Details")
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .foregroundColor(vm.backgroundColor)
                            }
                        }
                        .padding(.leading, 30)
                        .padding(.bottom)
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
                                    .foregroundColor(vm.backgroundColor)
                            }
                        }
                        .padding(.trailing, 30)
                        .padding(.bottom)
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 60)
                            .frame(height: 400)
                            .ignoresSafeArea()
                            .padding(.horizontal, 30)
                        
                    }
                    
                }
//                .padding(.top, 75)
            }
        }
        .foregroundColor(.white)
    }
}

extension HomeView {
    func getbackgroundColor(airData: AirData) -> Color {
        if airData.current.pollution.aqius <= 50 {
            return Color("GoodAQI")
        } else if airData.current.pollution.aqius <= 100 {
            return Color("ModerateAQI")
        } else if airData.current.pollution.aqius <= 150 {
            return Color("SlightlyUnhealthyAQI")
        } else if airData.current.pollution.aqius <= 200 {
            return Color("UnhealthyAQI")
        } else if airData.current.pollution.aqius <= 300 {
            return Color("VeryUnhealthyAQI")
        } else {
            return Color("HazardousAQI")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
