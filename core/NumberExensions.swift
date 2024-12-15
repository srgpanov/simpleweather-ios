//
//  NumberExensions.swift
//  simpleweather
//
//  Created by Панов Сергей on 03.01.2024.
//

import Foundation

extension Double{
    
    func toString() ->String{
        return String(self)
    }
    
    func toInt()->Int{
        return Int(self)
    }
    
    func roundToInt()->Int{
        return Int(self.rounded())
    }
}

extension Int{
    
    func toString() ->String{
        return String(self)
    }
   
    func toDouble() ->Double{
        return Double(self)
    }

}
