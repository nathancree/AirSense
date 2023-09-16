//
//  SearchView.swift
//  AirSense
//
//  Created by Nathan Cree on 9/15/23.
//

import SwiftUI

struct SearchView: View {
    @StateObject var searchvm = SearchViewModel()
    @StateObject var homevm: HomeViewModel
    @State var countrySelected: Bool = false
    @State var stateSelected: Bool = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.black)
                    .ignoresSafeArea()
                VStack (alignment: .leading, spacing: 50){
                    NavigationLink {
                        CountrySheetView(text: $searchvm.generalQuery, countrySelected: $countrySelected, vm: searchvm)
                    } label: {
                        Text("Country: \(searchvm.countryQuery)")
                    }
                    NavigationLink {
                        StateSheetView(text: $searchvm.generalQuery, stateSelected: $stateSelected, vm: searchvm)
                    } label: {
                        Text("State: \(searchvm.stateQuery)")
                    }
                    .disabled(!countrySelected)
                    NavigationLink {
                        CitySheetView(text: $searchvm.generalQuery, homevm: homevm, vm: searchvm)
                    } label: {
                        Text("City")
                    }
                    .disabled(!countrySelected && !stateSelected)
                }
                .fontWeight(.bold)
                .font(.system(size: 50))
            }
            .foregroundColor(.white)
        }
    }
}

struct CountrySheetView: View {
    @Binding var text: String
    @Binding var countrySelected: Bool
    var vm: SearchViewModel
    @State var filteredCountries: [Country] = []
    var body: some View {
        VStack {
            Text(vm.countryQuery.isEmpty ? "No Country Selected" : vm.countryQuery)
                .font(.title)
                .fontWeight(.bold)
            HStack {
                Button {
                    filteredCountries = vm.filterCountries(text: text)
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.leading)
                }
                TextField("", text: $text)
                    .background(.white)
                    .accentColor(.black)
                    .foregroundColor(.black)
                    .cornerRadius(20)
                    .padding(.horizontal, 40)
            }
            .padding(.top)
            
            ScrollView(showsIndicators: false) {
                ForEach(filteredCountries) { country in
                    Button {
                        vm.setCountryQuery(text: country.country)
                        text = ""
                        countrySelected = true
                        vm.printCountryAndState() //for debugging
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                            HStack {
                                Text(country.country)
                                    .foregroundColor(.black)
                                    .padding(.leading, 30)
                                Spacer()
                            }
                        }
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct StateSheetView: View {
    @Binding var text: String
    @Binding var stateSelected: Bool
    var vm: SearchViewModel
    @State var filteredStates: [States] = []
    var body: some View {
        VStack {
            Text(vm.stateQuery.isEmpty ? "No State Selected" : vm.stateQuery)
                .font(.title)
                .fontWeight(.bold)
            HStack {
                Button {
                    filteredStates = vm.filterStates(text: text, country: vm.countryQuery)
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.leading)
                }
                TextField("", text: $text)
                    .background(.white)
                    .accentColor(.black)
                    .foregroundColor(.black)
                    .cornerRadius(20)
                    .padding(.horizontal, 40)
            }
            .padding(.top)
            
            ScrollView(showsIndicators: false) {
                ForEach(filteredStates) { state in
                    Button {
                        vm.setStateQuery(text: state.state)
                        text = ""
                        stateSelected = true
                        vm.printCountryAndState() //for debugging
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                            HStack {
                                Text(state.state)
                                    .foregroundColor(.black)
                                    .padding(.leading, 30)
                                Spacer()
                            }
                        }
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct CitySheetView: View {
    @Binding var text: String
    var homevm: HomeViewModel
    var vm: SearchViewModel
    @State var filteredCities: [City] = []
    var body: some View {
        VStack {
            HStack {
                Button {
                    filteredCities = vm.filterCities(text: text, country: vm.countryQuery, state: vm.stateQuery)
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.leading)
                }
                TextField("", text: $text)
                    .background(.white)
                    .accentColor(.black)
                    .foregroundColor(.black)
                    .cornerRadius(20)
                    .padding(.horizontal, 40)
            }
            .padding(.top)
            
            ScrollView(showsIndicators: false) {
                ForEach(filteredCities) { city in
                    Button {
//                        homevm.addLocation(vm.getAirDataFromCityData(country: vm.countryQuery, state: vm.stateQuery, city: city.city))
                        Task {
                            await fetchAndUpdateCity(city)
                        }
                        text = ""
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                            HStack {
                                Text(city.city)
                                    .foregroundColor(.black)
                                    .padding(.leading, 30)
                                Spacer()
                            }
                        }
                    }
                }
            }
            
            Spacer()
        }
    }
}

extension CitySheetView{
    @MainActor private func fetchAndUpdateCity(_ city: City) async {
        let updatedAirData: AirData = vm.getAirDataFromCityData(country: vm.countryQuery, state: vm.stateQuery, city: city.city)
        await addToUserDefaults(updatedAirData)
        
    }
    
    @MainActor private func addToUserDefaults(_ airData: AirData) async {
        do {
            try await homevm.addLocation(airData)
        } catch {
            print("\(error)")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(homevm: HomeViewModel())
    }
}
