//
//  WeatherRepository.swift
//  simpleweather
//
//  Created by Панов Сергей on 03.01.2024.
//

import RxAlamofire
import RxSwift
import Foundation

class WeatherRepository {
    
    
    func getWeatherFull(latitude:Double = 45.035469,lonitude:Double = 38.975309,locale:String = "ru") -> Single<WeatherResponse> {
        let key = "183efae9ce2049719f6123655241011"
        let apiUrl = "https://api.weatherapi.com/v1/forecast.json?key=\(key)&q=\(latitude),\(lonitude)&aqi=no"
        return RxAlamofire.requestData(
            .get,
            apiUrl


        )
        .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
        .map { (response, data:Data)->WeatherResponse in
            let decoder = JSONDecoder()
            

            decoder.dateDecodingStrategy = .secondsSince1970

            
            return try decoder.decode(WeatherResponse.self, from: data )
        }
        .asSingle()
        .do (onSuccess: { WeatherResponse in
            print("22")
            
        }) { Error in
            print("Error=\(Error)")
        }
    
       
    }
}
