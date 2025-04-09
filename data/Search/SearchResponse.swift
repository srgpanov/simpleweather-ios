//
//  SearchResponse.swift
//  simpleweather
//
//  Created by Панов Сергей on 17.11.2024.
//

import Foundation


// MARK: - SearchResponseElement
struct SearchEntityDto: Codable,Equatable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double

    
    init(place:WeatherPlace){
        self.id = place.id
        self.name = place.name
        self.region = place.region
        self.country = place.country
        self.lat = place.geoLocation.latitude
        self.lon = place.geoLocation.longitude
    }
    
    init(id: Int, name: String, region: String, country: String, lat: Double, lon: Double) {
        self.id = id
        self.name = name
        self.region = region
        self.country = country
        self.lat = lat
        self.lon = lon
    }
    
    

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case region = "region"
        case country = "country"
        case lat = "lat"
        case lon = "lon"
    }
}


struct SearchResponse: Codable {
    let searchResults: [SearchEntityDto]?

    // Используем ключ, который будет соответствовать вашему JSON, если он есть.
    enum CodingKeys: String, CodingKey {
        case searchResults = "" // Здесь указывается правильный ключ, если он есть.
    }
}
