//
//  WeatherHeaderItem.swift
//  simpleweather
//
//  Created by Панов Сергей on 29.09.2023.
//

import Foundation

struct WeatherHeaderRvItem : RvItem{
    public static let identifier = "WeatherHeaderRvItem"
    
    let identifier: String = identifier
    let temp: String
    let icon: String
    let tempFeels: String
    let condition: String
    let weatherDetailItems:[RvItem]
}
