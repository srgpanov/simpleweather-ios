//
//  ForecastViewModel.swift
//  simpleweather
//
//  Created by Панов Сергей on 10.04.2025.
//

import UIKit
import RxSwift

class ForecastViewModel {
    private lazy var converter = ForecastConverter()
    
    private lazy var  dayForecast = Observable.just(createForecastModel()    )
    
    lazy var dayForecastUi:Observable<ForecastUi> = {
        dayForecast.map { forecast in
            self.converter.mapToForecastUi(forecast:forecast)
        }
    }()
    
    
    private  func createForecastModel() -> ForecastModel{
        return ForecastModel(
            temp:                DayTemp(
                measurements:Measurements.Temp.CELSIUS,
                morning: 10.0,
                day: 20.0,
                evening: 30.0,
                night: 15.0
            ),
            wind: DayWind(
                measurements:Measurements.WindSpeed.M_S,
                morning: 15.0,
                day: 15.0,
                evening: 25.0,
                night: 35.0
            ),
            humidity: DayHumidity(
                morning: 1.0,
                day: 2.0,
                evening: 75.0,
                night: 150.0
            ),
            pressure: DayPressure(
                measurements:Measurements.Pressure.MM_OF_MERCURY,
                morning: 700.0,
                day: 800.0,
                evening: 900.0,
                night: 750.0
            )
        )
    }
}
