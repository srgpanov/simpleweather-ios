//
//  UserLocationItem.swift
//  simpleweather
//
//  Created by Панов Сергей on 08.04.2025.
//

import Foundation


struct UserLocationRvItem:RvItem{
    static var identifier: String = "UserLocationRvItem"
    
    
    var customLocationIcon:String = "ic_ovc"
    var customLocationText:String = "custom_location".asStringRes()
    var geoPositionLocationIcon:String = "ic_ovc"
    var geoPositionLocationText:String = "geo_location".asStringRes()
    
}
