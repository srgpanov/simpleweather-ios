//
//  WeatherHourlyRvItem.swift
//  simpleweather
//
//  Created by Панов Сергей on 01.10.2023.
//

import Foundation
import UIKit

struct WeatherHourlyRvItem : RvItem{
    public static let identifier = "WeatherHourlyRvItem"
    var identifier: String = WeatherHourlyRvItem.identifier
    
    let hourTime: String
    let hourTemp: String
    let textSize: Float
    let textTypeFace: Int
    let icon: String
}
