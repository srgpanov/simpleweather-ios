//
//  ForecastUi.swift
//  simpleweather
//
//  Created by Панов Сергей on 18.05.2025.
//

import UIKit

class ForecastUi {

    let temp:DayTempUi
    let wind:DayWindUi
    let humidity:DayHumidityUi
    let pressure:DayPressureUi
    
    init(temp: DayTempUi, 
         wind: DayWindUi,
         humidity: DayHumidityUi,
         pressure: DayPressureUi
    ) {
        self.temp = temp
        self.wind = wind
        self.humidity = humidity
        self.pressure = pressure
    }

    
    
    struct DayTempUi{
        let morning:String
        let day:String
        let evening:String
        let night:String
    }
    struct DayWindUi{
        let morning:String
        let day:String
        let evening:String
        let night:String
    }
    struct DayHumidityUi{
        let morning:String
        let day:String
        let evening:String
        let night:String
    }

    struct DayPressureUi{
        let measurements:String
        let morning:String
        let day:String
        let evening:String
        let night:String
    }

}
