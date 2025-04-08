//
//  SettingsSwitchRvItem.swift
//  simpleweather
//
//  Created by Панов Сергей on 10.03.2024.
//

import UIKit

struct SettingsSwitchRvItem: RvItem {
    public static let identifier = "SettingsSwitchRvItem"

    
    let routerId:Int
    let isTurnOn:Bool

    let text:String
    let turnOnText:String = ""
    let turnOffText:String = ""
}
