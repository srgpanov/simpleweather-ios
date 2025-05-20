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
    let dayIndicator:DayIndicatorUi
    
    init(temp: DayTempUi, 
         wind: DayWindUi,
         humidity: DayHumidityUi,
         pressure: DayPressureUi,
         dayIndicator: DayIndicatorUi
    ) {
        self.temp = temp
        self.wind = wind
        self.humidity = humidity
        self.pressure = pressure
        self.dayIndicator = dayIndicator
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
    
    struct DayIndicatorUi{
        let moonPhaseIndicator:MoonPhaseUi
        let moonPhaseLine:DayIndicatorLine
        let waterTempLine:DayIndicatorLine
        
        
        struct DayIndicatorLine{
            let left:String
            let right:String
        }
        
        struct MoonPhaseUi{
            let sunrise:String
            let sunset:String
            let dayTime:String
            
            init(sunrise: DateComponents, sunset: DateComponents, dayTime: DateComponents) {
                let formatter = DateComponentsFormatter()
                formatter.unitsStyle = .positional
                formatter.zeroFormattingBehavior = .pad
                formatter.allowedUnits = [.hour, .minute]
                
                self.sunrise = formatter.string(from: sunrise)!
                self.sunset = formatter.string(from: sunset)!
                
                formatter.unitsStyle = .short
                self.dayTime = formatter.string(from: dayTime)!
            }
        }
    }

}
