//
//  Forecast.swift
//  simpleweather
//
//  Created by Панов Сергей on 10.04.2025.
//

import UIKit

struct ForecastModel{
    let temp:DayTemp
    let wind:DayWind
    let humidity:DayHumidity
    let pressure:DayPressure
}

struct DayTemp{
    let measurements:Measurements.Temp
    let morning:Double
    let day:Double
    let evening:Double
    let night:Double
}
struct DayWind{
    let measurements:Measurements.WindSpeed
    let morning:Double
    let day:Double
    let evening:Double
    let night:Double
}
struct DayHumidity{
    let morning:Double
    let day:Double
    let evening:Double
    let night:Double
}

struct DayPressure{
    let measurements:Measurements.Pressure
    let morning:Double
    let day:Double
    let evening:Double
    let night:Double
}

