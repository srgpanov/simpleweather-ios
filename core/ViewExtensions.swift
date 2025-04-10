//
//  ViewExtensions.swift
//  simpleweather
//
//  Created by Панов Сергей on 10.04.2025.
//

import UIKit

extension UILabel {
    
    var textSize: CGFloat {
        get {
            return self.font.pointSize
        }
        set {
            self.font = self.font.withSize(newValue)
        }
    }
}
