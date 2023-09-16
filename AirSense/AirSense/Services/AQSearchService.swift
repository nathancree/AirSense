//
//  AQSearchService.swift
//  AirSense
//
//  Created by Nathan Cree on 9/16/23.
//

import Foundation

struct AQSearchService {
    private let session: URLSession = .shared
    private let decoder: JSONDecoder = AirData.decoder
    
    public func searchCountries() async throws -> [Country] {
        print("search air data called")
        
        //make url
        let urlString = URLComponents(string: "https://api.airvisual.com/v2/countries?key=1a55c04-3c86-49be-ac7b-0c6fdce8c093")
        
        //create query item list
        
        //add query list to existing url
        guard let url = urlString?.url else { fatalError("Invalid URL") }
        
        
        //begin fetching the data and wait for the response to come back
        let (data, _) = try await session.data(from: url)
        
        //decode name from 'Data' type using our `JSONDecoder`
        let response = try decoder.decode(CountryResponse.self, from: data)
        
        //return decoded name
        return response.country
        
    }
    
    public func searchStates(country: String) async throws -> [State] {
        print("search air data called")
        
        //make url
        let urlString = URLComponents(string: "https://api.airvisual.com/v2/states?country=\(country)&key=1a55c04-3c86-49be-ac7b-0c6fdce8c093")
        
        //create query item list
        
        //add query list to existing url
        guard let url = urlString?.url else { fatalError("Invalid URL") }
        
        
        //begin fetching the data and wait for the response to come back
        let (data, _) = try await session.data(from: url)
        
        //decode name from 'Data' type using our `JSONDecoder`
        let response = try decoder.decode(StateResponse.self, from: data)
        
        //return decoded name
        return response.state
        
    }
    
    public func searchCities(country: String, state: String) async throws -> [City] {
        print("search air data called")
        
        //make url
        let urlString = URLComponents(string: "https://api.airvisual.com/v2/cities?state=\(state)&country=\(country)&key=1a55c04-3c86-49be-ac7b-0c6fdce8c093")
        
        //create query item list
        
        //add query list to existing url
        guard let url = urlString?.url else { fatalError("Invalid URL") }
        
        
        //begin fetching the data and wait for the response to come back
        let (data, _) = try await session.data(from: url)
        
        //decode name from 'Data' type using our `JSONDecoder`
        let response = try decoder.decode(CityResponse.self, from: data)
        
        //return decoded name
        return response.city
        
    }
    
    public func getCityData(country: String, state: String, city: String) async throws -> CityData {
        print("search air data called")
        
        //make url
        let urlString = URLComponents(string: "https://api.airvisual.com/v2/city?city=\(city)&state=\(state)&country=\(country)&key=1a55c04-3c86-49be-ac7b-0c6fdce8c093")
            
        
        //create query item list
        
        //add query list to existing url
        guard let url = urlString?.url else { fatalError("Invalid URL") }
        
        
        //begin fetching the data and wait for the response to come back
        let (data, _) = try await session.data(from: url)
        
        //decode name from 'Data' type using our `JSONDecoder`
        let response = try decoder.decode(CityDataResponse.self, from: data)
        
        //return decoded name
        return response.location
        
    }
}
