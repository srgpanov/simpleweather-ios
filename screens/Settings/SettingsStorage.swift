//
//  SettingsStorage.swift
//  simpleweather
//
//  Created by Панов Сергей on 10.03.2024.
//

import Foundation


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

