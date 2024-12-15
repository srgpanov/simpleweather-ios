//
//  ArrayExtensions.swift
//  simpleweather
//
//  Created by Панов Сергей on 08.12.2024.
//

import Foundation

extension Array {
    func take( count: Int) -> Array {
        if self.count<=count{
            return self
        }
        
        return Array(self.prefix(count))
    }
}
