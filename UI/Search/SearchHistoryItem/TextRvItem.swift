//
//  SearchHistoryRvItem.swift
//  simpleweather
//
//  Created by Панов Сергей on 27.10.2024.
//

import Foundation
import UIKit


struct TextRvItem:RvItem{
    public static let identifier = "TextRvItem"
    var identifier: String = TextRvItem.identifier
    
    let routerId:Int
    let text:String
    let fontSize:CGFloat
    let textColor:UIColor
    
    
    
}
