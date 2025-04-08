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
        print("save \(measurements)")
        storage.set(measurements.temp != .CELSIUS, forKey: "temp")
        storage.set(measurements.windSpeed != .M_S, forKey: "windSpeed")
        storage.set(measurements.pressure != .MM_OF_MERCURY, forKey: "pressure")
    }
    

}


class SettingsStorage{
        private static let  KEY_CURRENT_LOCATION = "KEY_CURRENT_LOCATION"
    
    
    func getCurrentLocationStream()-> Observable<SearchEntityDto>{
        return UserDefaults.standard.observable(objectType: SearchEntityDto.self, key: SettingsStorage.KEY_CURRENT_LOCATION,defaultValue: {self.getDefaultLocation()})
            .do { dto in
            print("dto=\(dto)")
            }
    }
    func getCurrentLocation()-> SearchEntityDto{
        let fromStorage = UserDefaults.standard.get(objectType: SearchEntityDto.self, forKey:  SettingsStorage.KEY_CURRENT_LOCATION)
        print("getCurrentLocation = \(fromStorage)")
        return fromStorage ?? getCurrentLocation()
    }
    
    private func getDefaultLocation()->SearchEntityDto {
        print("getDefaultLocation")
       return SearchEntityDto(
            id:1,
                name:"Краснодар",
                region:"",
                country:"",
                lat:45.035469,
                lon:38.975309,
                url:""
        )
    }
    
    func setCurrentLocation (dto:SearchEntityDto)  {
        UserDefaults.standard.set(object: dto ,forKey: SettingsStorage.KEY_CURRENT_LOCATION)
    }
}

