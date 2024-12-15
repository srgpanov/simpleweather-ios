//
//  Measurements.swift
//  simpleweather
//
//  Created by Панов Сергей on 10.03.2024.
//

import UIKit

struct Measurements  {
    var temp:Temp = Temp.CELSIUS
    var windSpeed:WindSpeed = WindSpeed.M_S
    var pressure:Pressure = Pressure.MM_OF_MERCURY
    
    
    
    
    enum Temp{
        case CELSIUS
        case FARINGHEIT
    }
    
    enum WindSpeed{
        case M_S
        case KM_H
    }
    
    enum Pressure{
        case MM_OF_MERCURY
        case H_PA
    }
}
