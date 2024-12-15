//
//  WeatherDayRvItem.swift
//  simpleweather
//
//  Created by Панов Сергей on 01.10.2023.
//

import Foundation
import UIKit

struct WeatherDayRvItem:RvItem{
    public static let identifier = "WeatherHourlyRvItem"
    var identifier: String = WeatherHourlyRvItem.identifier 
    
    let date: String
    let dayWeek: String
    let textColor: Int
    let tempDay: String
    let tempNight: String
    let icon: String
}
