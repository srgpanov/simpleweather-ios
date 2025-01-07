//
//  WeatherConverter.swift
//  simpleweather
//
//  Created by Панов Сергей on 03.01.2024.
//

import Foundation
import UIKit

class WeatherConverter{
    private let dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        return formatter
    }()
    
    private let weekDayFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
    private let hoursFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
    private let calendar = Calendar.current
    
    private func createToolbarBtn(imageRes: String) -> UIImage {
        return UIImage(named: imageRes)!

    }
    func createToolbarRightSettingsButton()->UIImage {
        return createToolbarBtn(imageRes:"ic_ovc")
    }
    
    func createToolbarRightFavouriteButton(isFavourite:Bool)->UIImage {
        let imageRes:String
        if isFavourite{
            imageRes = "ic_favourite_outline"
        }else{
            imageRes = "ic_favourite_filled"
        }
        return createToolbarBtn(imageRes:imageRes)
    }
    func createItemsList(response:WeatherResponse)->[RvItem]{
        var items = createDaysItems(response)
        items.insert(createHeaderItem(response:response), at: 0)
        return items
        
    }
    
    private func createHeaderItem(response: WeatherResponse) -> WeatherHeaderRvItem{
        let current:CurrentWeather = response.current
        let condictionStr = current.condition.text
        
        let feelsLikeRes = NSLocalizedString("details_screen_temp_feels_like_prefix", comment: "")
        let feelsLikeFormatted = String(format: feelsLikeRes, current.feelslikeC.formatTemp())
        
        var weatherDetailItems = createHourlyItems(response: response)
        weatherDetailItems.insert(createWeatherDetailItem(current: current), at: 0)
        
        return WeatherHeaderRvItem(
            temp:current.tempC.formatTemp(),
            icon: "ic_ovc",
            tempFeels:feelsLikeFormatted,
            condition:condictionStr,
            weatherDetailItems:weatherDetailItems
        )
    }
    
    private func createWeatherDetailItem(current:CurrentWeather) -> RvItem{
        let windMeasure = "common_metr_in_seconds".asStringRes()
        
        let pressureMeasurement = "common_pressure_mmhg".asStringRes()
        return WeatherDetailRvItem(
            windSpeed:"\(windMeasure), \(current.getWindDirection())",
            windSpeedValue:current.windKph.rounded().toInt().toString(),
            windDirectionIcon:0,
            pressureValue:getPressureValue(current: current),
            pressureMeasurement:pressureMeasurement,
            humidity:current.humidity.toString()
        )
    }
    private func createHourlyItems(response:WeatherResponse)->[RvItem]{
        var resultList:[RvItem] = []
        
        guard  let forecast:ForecastDay =  response.forecast.forecastday.first else {
            return []
        }
        var hours:[HourlyWeather] = forecast  .hour
        
        for hour in hours {
            

            resultList.append(
                WeatherHourlyRvItem (
                    hourTime : hoursFormatter.string(from:  Date()),
                    hourTemp : hour.tempC.formatTemp(),
                    textSize : 16,
                    textTypeFace :0,
                    icon: "ic_ovc"
                )
            )
            
//            
//            for daily in response.daily {
//                if haveSameDateAndHour(date1: daily.sunrise, date2: hour.date){
//                    resultList.append(
//                        WeatherHourlyRvItem(
//                            hourTime : hoursFormatter.string(from: daily.sunrise),
//                            hourTemp : "comon_sunrise".asStringRes(),
//                            textSize : 16,
//                            textTypeFace :0,
//                            icon: "ic_ovc"
//                        )
//                    )
//                }
//                
//                if haveSameDateAndHour(date1: daily.sunset, date2: hour.date){
//                    resultList.append(
//                        WeatherHourlyRvItem(
//                            hourTime : hoursFormatter.string(from: daily.sunset),
//                            hourTemp : "common_sunset".asStringRes(),
//                            textSize : 16,
//                            textTypeFace :0,
//                            icon: "ic_ovc"
//                        )
//                    )
//                }
//            }
            
            
        }
        
        return resultList
        
        
    }
    
    private func isCurrentDay(date:Date) -> Bool{
        
        let currentDate = Date()
        
        let currentComponents = calendar.dateComponents([.year, .month, .day, .hour], from: currentDate)
        
        guard let current = calendar.date(from: currentComponents) else {
            return false
        }
        
        
        return calendar.isDate(current, inSameDayAs: date)
    }
    
    
    func haveSameDateAndHour(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        let components1 = calendar.dateComponents([.year, .month, .day, .hour], from: date1)
        let components2 = calendar.dateComponents([.year, .month, .day, .hour], from: date2)
        
        return (components1.year == components2.year &&
                components1.month == components2.month &&
                components1.day == components2.day &&
                components1.hour == components2.hour)
    }
    
    func checkDateAndHour(_ date: Date, hour: Int) -> Bool {
        let calendar = Calendar.current
        
        
        // Получаем текущую дату и время
        let currentDate = Date()
        // Получаем компоненты текущей и проверяемой даты
        let currentComponents = calendar.dateComponents([.year, .month, .day, .hour], from: currentDate)
        let targetComponents = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        
        // Проверяем, что это текущий день
        guard let current = calendar.date(from: currentComponents), let target = calendar.date(from: targetComponents) else {
            return false
        }
        
        if calendar.isDate(current, inSameDayAs: target) {
            // Проверяем, что текущий час совпадает с конкретным часом
            return currentComponents.hour == hour
        } else {
            return false
        }
    }
    
    
    private func formatDayDate(index:Int, date: Date) -> String {
        switch index {
        case 0:
            return "common_today".asStringRes()
        case 1:
            return "common_tomorrow".asStringRes()
        default:
            return dateFormatter.string(from: date)
        }
    }
    
    private func getPressureValue(current: CurrentWeather)-> String {
        let coefficient = 0.7501
        return              (current.precipMm * coefficient).roundToInt().toString()
        
    }
    
    fileprivate func createDaysItems(_ response: WeatherResponse) -> [RvItem] {
        return response.forecast.forecastday.enumerated() .map { (index, daily:ForecastDay) in
            WeatherDayRvItem(
                date: formatDayDate(index:index,date:Date()),
                dayWeek: weekDayFormatter.string(from: Date()).capitalized,
                textColor: 0,
                tempDay: daily.day.maxtempC.formatTemp(),
                tempNight: daily.day.mintempC.formatTemp(),
                icon: "ic_ovc"
            )
        }
    }
}

private extension Double{
    func formatTemp() -> String{
        switch Int(self) {
        case let x where x < 0:
            return String(x)+"°"
        case let x where x == 0:
            return String(x)+"°"
        case let x where x > 0:
            return "+" + String(x)+"°"
        default:
            fatalError()
        }
    }
}
private extension CurrentWeather{
    func getWindDirection() -> String {
        switch self.windDegree {
        case  338...360 , 0...22:
            "N"
        case 23...67:
            "NE"
        case 68...112:
            "E"
        case 113...157:
            "SE"
        case 158...202:
            "S"
        case 203...247:
            "SW"
        case 248...292:
            "W"
        case 293...337:
            "NW"
        default:
            fatalError()
        }
    }
}
