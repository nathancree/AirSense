//
//  HomeView.swift
//  AirSense
//
//  Created by Nathan Cree on 9/15/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homevm: HomeViewModel
    var body: some View {
        ZStack {
            HomeDetailSubview(vm: homevm)
//            Button {
//                print("button clicked")
//                homevm.getAirData()
//            } label: {
//                Rectangle()
//                    .foregroundColor(.black)
//            }
        }
        .foregroundColor(.white)
        
        
    }
    
    private var favoriteList: some View {
        ScrollView(showsIndicators: false) {
            ForEach(homevm.favAirData) { airData in
                NavigationLink {
                    AirDataDetailsView(airDetailsVm: AirDataDetailsViewModel(airData: homevm.airData))
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(homevm.getbackgroundColor(airData: airData))
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
    @StateObject var vm: HomeViewModel
    var body: some View {
        NavigationStack {
            ZStack {
                vm.getbackgroundColor(airData: vm.airData)
//                Color(.black)
                    .ignoresSafeArea()
                VStack{
                    ZStack {
                        HStack {
                            NavigationLink {
                                SearchView()
                            } label: {
                                Image(systemName: "magnifyingglass.circle.fill")
                                    .font(.system(size: 35))
                            }
                            .padding(.leading, 30)
                            .padding(.trailing, 85)
                            Spacer()
                        }
                        VStack {
                            Text(vm.airData.city ?? "")
                                .font(.title2)
                                .fontWeight(.semibold)
                            HStack {
                                Text(vm.airData.country ?? "")
                                Text(vm.airData.state ?? "")
                            }
                        }
                    }
                    .padding(.bottom, 10)
                    ZStack {
                        Circle()
                            .stroke(.white, lineWidth: 8)
                        VStack {
                            Text("AQI")
                                .font(.title2)
                            Text("\(Int(vm.airData.current.pollution.aqius))")
                                .fontWeight(.bold)
                                .font(.system(size: 75))
                            
                        }
                    }
                    
                    HStack {
                        NavigationLink {
                            AirDataDetailsView(airDetailsVm: AirDataDetailsViewModel(airData: vm.airData))
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 120, height: 50)
                                Text("Details")
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .foregroundColor(vm.getbackgroundColor(airData: vm.airData))
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
                                    .foregroundColor(vm.getbackgroundColor(airData: vm.airData))
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
        .accentColor(.white)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let homevm = HomeViewModel()
        HomeView(homevm: homevm)
    }
}
