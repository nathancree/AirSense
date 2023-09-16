//
//  AirQualityService.swift
//  AirSense
//
//  Created by Nathan Cree on 9/15/23.
//

import Foundation

struct AirQualityService {
    private let session: URLSession = .shared //what this do??
    private let decoder: JSONDecoder = AirData.decoder
    //api key: f1a55c04-3c86-49be-ac7b-0c6fdce8c093
    
    
    public func getAirQuality() async throws -> AirData { //need to specify parameters (check api documentation for help)
        print("Fetching air quality")
        
        //make url
        let urlString = URLComponents(string: "https://api.airvisual.com/v2/nearest_city?lat=35.910259&lon=-79.055473&key=f1a55c04-3c86-49be-ac7b-0c6fdce8c093")
    
        
        //create query item list
        
        //add query list to existing url
        guard let url = urlString?.url else { fatalError("Invalid URL") }
        
        
        //begin fetching the data and wait for the response to come back
        let (data, _) = try await session.data(from: url)
        
        //decode name from 'Data' type using our `JSONDecoder`
        let response = try decoder.decode(Response.self, from: data)
        
        //return decoded name
        return response.data
    }
    
    
    
    
}
