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
    let url: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case region = "region"
        case country = "country"
        case lat = "lat"
        case lon = "lon"
        case url = "url"
    }
}


struct SearchResponse: Codable {
    let searchResults: [SearchEntityDto]?

    // Используем ключ, который будет соответствовать вашему JSON, если он есть.
    enum CodingKeys: String, CodingKey {
        case searchResults = "" // Здесь указывается правильный ключ, если он есть.
    }
}
