//
//  StringExtensions.swift
//  simpleweather
//
//  Created by Панов Сергей on 05.01.2024.
//

import Foundation

extension String{
    
    func asStringRes() -> String{
        let localizedStr = NSLocalizedString(self, comment: "")
        return localizedStr
    }
    
    func asStringRes(arguments: CVarArg...) -> String {
        let localizedStr = NSLocalizedString(self, comment: "")
        return String(format: localizedStr, arguments: arguments)
    }
}

extension Optional where Wrapped == String {
    func orEmpty() -> String{
        return if self != nil {
            self!
        } else{
            ""
        }
    }
}
