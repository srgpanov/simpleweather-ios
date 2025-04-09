//
//  FavouriteStorage.swift
//  simpleweather
//
//  Created by Панов Сергей on 04.01.2025.
//

import Foundation
import RxSwift

class FavouriteStorage{
    private let storage = UserDefaults.standard
    
    private static let KEY_FAVOURITES = "KEY_FAVOURITES"
    
    
    func changeFavouriteStatus(element:WeatherPlace){
        var currentSearchList:[SearchEntityDto] =  storage.readArray(forKey:  FavouriteStorage.KEY_FAVOURITES)
        let index :Int? = currentSearchList.firstIndex { dto in
            dto.id==element.id
        }
        if index != nil{
            currentSearchList.remove(at: index!)
        } else {
            currentSearchList.insert(SearchEntityDto(place: element), at: 0)
        }
        
        
        
        
        storage.saveArray(array: currentSearchList, forKey: FavouriteStorage.KEY_FAVOURITES)
    }
    
    func isFavourite(locationId:Int)->Observable<Bool>{
        return getFavouriteElements()
            .map { elements in
                elements.contains { dto in
                    dto.id == locationId
                }
            }
    }
    
    func getFavouriteElements() -> Observable<[WeatherPlace]>{
        return storage.observableArray(key:FavouriteStorage.KEY_FAVOURITES)
            .map { (dtos:[SearchEntityDto]) in
                dtos.map { dto in
                    dto.toWeatherPlace()
                }
            }
    }
    
    func getFavouriteElements() -> [WeatherPlace]{
        let dtos:[SearchEntityDto] = storage.readArray(forKey: FavouriteStorage.KEY_FAVOURITES)
        
        return dtos.map { (dto: SearchEntityDto) -> WeatherPlace in
            dto.toWeatherPlace()
        }

    }
}

