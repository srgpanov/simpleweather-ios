//
//  WeatherDetailsViewModel.swift
//  simpleweather
//
//  Created by Панов Сергей on 03.01.2024.
//

import Foundation
import RxSwift


class WeatherDetailsViewModel{
    private let repository = WeatherRepository()
    private let converter = WeatherConverter()
    
    let location:GeoLocation
    
    init(location:GeoLocation){
        self.location = location
    }
    
    func getWeather() -> Single<[RvItem]>{
        
        return repository.getWeatherFull(latitude: location.latitude, lonitude:location.longitude)
            .map { response in
                self.converter.createItemsList(response: response)
            }
            .observe(on: MainScheduler.instance)
            .do (onSuccess: { (s:[RvItem]) in
                print("s=\(s)"
                )
                
            }, onError: { Error in
                print("Error=\(Error)")
            })
    }
}
