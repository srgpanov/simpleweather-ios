//
//  FavouriteItem.swift
//  simpleweather
//
//  Created by Панов Сергей on 04.01.2025.
//

import Foundation


struct FavouriteRvItem:RvItem{
    public static let identifier = "FavouriteRvItem"
    
    var identifier: String = FavouriteRvItem.identifier
    
    let title:String
    let time:String
    let temp:String
    let icon:String
    
    let sharedArgs:Any?
}
