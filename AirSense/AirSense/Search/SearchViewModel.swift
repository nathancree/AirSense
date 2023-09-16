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
    @Published var countries: [Country] = []
    @Published var states: [State] = []
    @Published var cities: [City] = []
    @Published var cityAirData: [AirData] = []
    
    private func setCountries(countries: [Country]) {
        self.countries = countries
    }
    
    private func setStates(states: [State]) {
        self.states = states
    }
    
    private func setCities(cities: [City]) {
        self.cities = cities
    }
    
    private func setAirData(airData: AirData) {
        cityAirData = [airData]
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
    
    func getStates(country: Country) {
        Task {
            do {
                print("getStates called")
                let states = try await searchService.searchStates(country: country.name)
                setStates(states: states)
            } catch {
                print("\(error)")
            }
        }
    }
    
    func getCities(country: Country, state: State) {
        Task {
            do {
                print("getCities called")
                let cities = try await searchService.searchCities(country: country.name, state: state.name)
                setCities(cities: cities)
            } catch {
                print("\(error)")
            }
        }
    }
    
    func getCityDetails(country: Country, state: State, city: City) {
        Task {
            do {
                let cityData = try await searchService.getCityData(country: country.name, state: state.name, city: city.name)
                setAirData(airData: try await airDataService.getLatLongAirQuality(lat: cityData.location.coordinates[0], lon: cityData.location.coordinates[1]))
            }
        }
    }
}
