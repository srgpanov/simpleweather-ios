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

extension UIView{
    func asCardView(){
        self.backgroundColor = .white
        self.layer.cornerRadius = 10.0
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.5
    }
}
