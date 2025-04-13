//
//  ForecastConverter.swift
//  simpleweather
//
//  Created by Панов Сергей on 18.05.2025.
//

import UIKit

class ForecastConverter {

 
    func mapToForecastUi(forecast:ForecastModel) -> ForecastUi{
        
        return ForecastUi(
            temp: forecast.temp.toUi(),
            wind: forecast.wind.toUi(),
            humidity: forecast.humidity.toUi(),
            pressure: forecast.pressure.toUi()
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
