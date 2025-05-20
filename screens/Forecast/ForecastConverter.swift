//
//  ForecastConverter.swift
//  simpleweather
//
//  Created by Панов Сергей on 18.05.2025.
//

import UIKit

class ForecastConverter {
    
    
    func mapToForecastUi(forecast:ForecastModel) -> ForecastUi{
        
        var sunrise = DateComponents()
        sunrise.hour = 5
        sunrise.minute = 32
        
        var sunset = DateComponents()
        sunset.hour = 19
        sunset.minute = 13
        
        var dayTime = DateComponents()
        dayTime.hour = 13
        dayTime.minute = 41
        
        let model = ForecastUi.DayIndicatorUi(
            moonPhaseIndicator: ForecastUi.DayIndicatorUi.MoonPhaseUi(sunrise: sunrise, sunset: sunset, dayTime: dayTime),
            moonPhaseLine:ForecastUi.DayIndicatorUi.DayIndicatorLine(left: "forecast_moon_phase".asStringRes(), right: "убывающая луна"),
            waterTempLine: ForecastUi.DayIndicatorUi.DayIndicatorLine(left: "forecast_temp_water".asStringRes(), right: "15°")
        )
        
        return ForecastUi(
            temp: forecast.temp.toUi(),
            wind: forecast.wind.toUi(),
            humidity: forecast.humidity.toUi(),
            pressure: forecast.pressure.toUi(),
            dayIndicator: model
        )
    }
    
    
    
}
fileprivate extension DayHumidity{
    func toUi()->ForecastUi.DayHumidityUi{
        return ForecastUi.DayHumidityUi(
            morning: "\(morning)%",
            day:  "\(day)%",
            evening: "\(evening)%",
            night:  "\(night)%"
        )
    }
}

fileprivate extension DayPressure{
    func toUi()->ForecastUi.DayPressureUi{
        return ForecastUi.DayPressureUi(
            measurements: measurements.toUi() ,
            morning: morning.toString(),
            day:  day.toString(),
            evening: evening.toString(),
            night: night.toString()
        )
    }
}
fileprivate extension DayWind{
    func toUi()->ForecastUi.DayWindUi{
        return ForecastUi.DayWindUi(
            morning: morning.toString(),
            day:  day.toString(),
            evening: evening.toString(),
            night: night.toString()
        )
    }
}

fileprivate extension DayTemp{
    func toUi()->ForecastUi.DayTempUi{
        return ForecastUi.DayTempUi(
            morning: morning.toString(),
            day:  day.toString(),
            evening: evening.toString(),
            night: night.toString()
        )
    }
}

fileprivate extension Measurements.Pressure{
    func toUi()->String{
        switch self {
        case .MM_OF_MERCURY:
            return  "мм рт. ст."
        case .H_PA:
            return "гПа"
        }
    }
}
