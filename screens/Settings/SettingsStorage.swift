//
//  SettingsStorage.swift
//  simpleweather
//
//  Created by Панов Сергей on 10.03.2024.
//

import Foundation
import RxSwift


protocol MeasurementsStorageProtocol {

 func load() -> Measurements

func save(measurements: Measurements)
}

class MeasurementsStorage: MeasurementsStorageProtocol {
    private var storage = UserDefaults.standard
    
    enum Temp : String {
        case CELSIUS
        case FARINGHEIT
    }
    
    enum WindSpeed : String {
        case M_S
        case KM_H
    }
    
    enum Pressure : String {
        case MM_OF_MERCURY
        case H_PA
    }
    
    func load() -> Measurements {
        let temp:Bool = storage.bool(forKey: "temp")
        let windSpeed = storage.bool(forKey: "windSpeed")
        let pressure = storage.bool(forKey: "pressure")
        
        let tempDomain:Measurements.Temp
        let windSpeedDomain:Measurements.WindSpeed
        let pressureDomain:Measurements.Pressure
        
        switch temp{

        case true:
            tempDomain = .FARINGHEIT
        case false:
            tempDomain = .CELSIUS
        }
        
        switch windSpeed{
        case true:
            windSpeedDomain = .KM_H
        case false:
            windSpeedDomain = .M_S
        }
        
        switch pressure{

        case true:
            pressureDomain = .H_PA
        case false:
            pressureDomain = .MM_OF_MERCURY
        }
    
        
        return Measurements(
            temp: tempDomain,
            windSpeed: windSpeedDomain,
            pressure: pressureDomain
        )
    }
    
    func save(measurements: Measurements) {
        storage.set(measurements.temp != .CELSIUS, forKey: "temp")
        storage.set(measurements.windSpeed != .M_S, forKey: "windSpeed")
        storage.set(measurements.pressure != .MM_OF_MERCURY, forKey: "pressure")
    }
    

}


class SettingsStorage{
        private static let  KEY_CURRENT_LOCATION = "KEY_CURRENT_LOCATION"
    
    
    func getCurrentLocationStream()-> Observable<WeatherPlace>{
        return UserDefaults.standard.observable(objectType: SearchEntityDto.self, key: SettingsStorage.KEY_CURRENT_LOCATION,defaultValue: {self.getDefaultLocation()})
            .map({ dto in
                dto.toWeatherPlace()
            })
            .do { dto in
            }
    }
    func getCurrentLocation()-> WeatherPlace{
        let fromStorage = UserDefaults.standard.get(objectType: SearchEntityDto.self, forKey:  SettingsStorage.KEY_CURRENT_LOCATION)
        return (fromStorage ?? getDefaultLocation()).toWeatherPlace()
    }
    
    private func getDefaultLocation()->SearchEntityDto {
        
       return SearchEntityDto(
            id:1,
                name:"Краснодар",
                region:"",
                country:"",
                lat:45.035469,
                lon:38.975309
        )
    }
    
    func setCurrentLocation (place:WeatherPlace)  {
        UserDefaults.standard.set(object: SearchEntityDto(place: place) ,forKey: SettingsStorage.KEY_CURRENT_LOCATION)
    }
}

