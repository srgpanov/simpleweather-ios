//
//  FavouriteConverter.swift
//  simpleweather
//
//  Created by Панов Сергей on 17.11.2024.
//

import Foundation
import UIKit


class FavouriteConverter{
    
    func createSearchItemsList(searchResponse:[SearchEntityDto])->[RvItem]{
        return searchResponse.map { (dto:SearchEntityDto) in
            TextRvItem(
                routerId: dto.id,
                text: "\(dto.country), \(dto.region), \(dto.name)",
                fontSize: 20,
                textColor: UIColor.lightGray
            )
        }
        
    }
    
    func createFavouriteItemsList(favourites:[SearchEntityDto]) ->[RvItem]{
        return favourites.map { (dto:SearchEntityDto) in
            FavouriteRvItem(
                title: dto.name ,
                time: "22:59",
                temp: "+23",
                icon:  "ic_ovc",
                sharedArgs: dto
            )
        }
    }
    
    func createCurrentItemsList(current:SearchEntityDto)->[RvItem]{
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
