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
        
        return    searchResponse.map { (dto:SearchEntityDto) in
            TextRvItem(
                routerId: dto.id,
                text: "\(dto.country), \(dto.region), \(dto.name)",
                fontSize: 20,
                textColor: UIColor.lightGray
            )
        }
        
    }
}
