//
//  WeatherDetailRvItem.swift
//  simpleweather
//
//  Created by Панов Сергей on 15.10.2023.
//

import UIKit

struct WeatherDetailRvItem: RvItem {
    public static let identifier = "WeatherDetailRvItem"
    
    let windSpeed: String
    let windSpeedValue: String
    let windDirectionIcon: Int
    let pressureValue: String
    let pressureMeasurement: String
    let humidity: String
}
