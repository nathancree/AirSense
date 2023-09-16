//
//  SearchViewModel.swift
//  AirSense
//
//  Created by Nathan Cree on 9/15/23.
//

import Foundation
@MainActor
class SearchViewModel: ObservableObject {
    
    private let searchService = AQSearchService()
    private let airDataService = AirQualityService()
    
    @Published var generalQuery: String = ""
    @Published var countryQuery: String = ""
    @Published var stateQuery: String = ""
    
    @Published var countries: [Country] = []
    @Published var states: [States] = []
    @Published var cities: [City] = []
    @Published var cityAirData: AirData = AirData.inital
    
    
    
    private func setCountries(countries: [Country]) {
        self.countries = countries
    }
    
    private func setStates(states: [States]) {
        self.states = states
    }
    
    private func setCities(cities: [City]) {
        self.cities = cities
    }
    
    private func setAirData(airData: AirData) {
        cityAirData = airData
    }
}

extension SearchViewModel {
    func getCountries() {
        Task {
            do {
                print("getCountries called")
                let countries = try await searchService.searchCountries()
                setCountries(countries: countries)
            } catch {
                print("\(error)")
            }
        }
    }
    
    func filterCountries(text: String) -> [Country] {
            getCountries()
        if text.isEmpty {
            return countries
        } else {
            return countries.filter { $0.country.localizedCaseInsensitiveContains(text) }
        }
    }
    
    func setCountryQuery(text: String) {
        self.countryQuery = text
    }
    
    func getStates(country: String) {
        Task {
            do {
                print("getStates called")
                let states = try await searchService.searchStates(country: country)
                setStates(states: states)
            } catch {
                print("\(error)")
            }
        }
    }
    
    func filterStates(text: String, country: String) -> [States] {
            getStates(country: country)
        if text.isEmpty {
            return states
        } else {
            return states.filter { $0.state.localizedCaseInsensitiveContains(text) }
        }
    }
    
    func setStateQuery(text: String) {
        self.stateQuery = text
    }
    
    func getCities(country: String, state: String) {
        Task {
            do {
                print("getCities called")
                let cities = try await searchService.searchCities(country: country, state: state)
                setCities(cities: cities)
            } catch {
                print("\(error)")
            }
        }
    }
    
    func filterCities(text: String, country: String, state: String) -> [City] {
            getCities(country: country, state: state)
        if text.isEmpty {
            return cities
        } else {
            return cities.filter { $0.city.localizedCaseInsensitiveContains(text) }
        }
    }
    
    func getCityDetails(country: String, state: String, city: String) async {
        Task {
            do {
                let cityData = try await searchService.getCityData(country: country, state: state, city: city)
                async let airQuality = airDataService.getLatLongAirQuality(lat: cityData.location.coordinates[0], lon: cityData.location.coordinates[1])
                setAirData(airData: try await airQuality)
                print("done getting and setting city data")
            } catch {
                print("\(error)")
            }
        }
    }
    
    func getAirDataFromCityData(country: String, state: String, city: String) async -> AirData {
        await getCityDetails(country: country, state: state, city: city)
        print("City Details \(cityAirData)")
        return cityAirData
    }
    
    //helper
    func printCountryAndState() {
        print(countryQuery)
        print(stateQuery)
    }
}
