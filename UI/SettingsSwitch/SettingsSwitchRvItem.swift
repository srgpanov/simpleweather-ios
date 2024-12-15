//
//  SettingsSwitchRvItem.swift
//  simpleweather
//
//  Created by Панов Сергей on 10.03.2024.
//

import UIKit

struct SettingsSwitchRvItem: RvItem {
    public static let identifier = "SettingsSwitchRvItem"
    var identifier: String = SettingsSwitchRvItem.identifier

    
    let routerId:Int
    let isTurnOn:Bool

    let text:String
    let turnOnText:String = ""
    let turnOffText:String = ""
}
