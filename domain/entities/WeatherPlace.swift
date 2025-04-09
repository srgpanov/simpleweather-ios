//
//  WeatherPlace.swift
//  simpleweather
//
//  Created by Панов Сергей on 08.12.2024.
//

import Foundation


struct WeatherPlace:Equatable{
    let id:Int
    let geoLocation:GeoLocation
    let name:String
    let country:String
    let region:String
}
