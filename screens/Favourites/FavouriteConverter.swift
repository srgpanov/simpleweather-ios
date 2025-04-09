//
//  FavouriteConverter.swift
//  simpleweather
//
//  Created by Панов Сергей on 17.11.2024.
//

import Foundation
import UIKit


class FavouriteConverter{
    
    func createSearchItemsList(searchResponse:[WeatherPlace])->[RvItem]{
        return searchResponse.map { (dto:WeatherPlace) in
            TextRvItem(
                routerId: dto.id,
                text: "\(dto.country), \(dto.region), \(dto.name)",
                fontSize: 20,
                textColor: UIColor.lightGray
            )
        }
        
    }
    
    func createFavouriteItemsList(favourites:[WeatherPlace]) ->[RvItem]{
        return favourites.map { (place:WeatherPlace) in
            FavouriteRvItem(
                title: place.name ,
                time: "22:59",
                temp: "+23",
                icon:  "ic_ovc",
                sharedArgs: place
            )
        }
    }
    
    func createCurrentItemsList(current:WeatherPlace)->[RvItem]{
        return [
            FavouriteRvItem(
                title:  current.name,
                time: "current_place".asStringRes(),
                temp: "+23",
                icon:  "ic_ovc",
                sharedArgs: current
            ),
            
            UserLocationRvItem()
        ]
    }
 }
