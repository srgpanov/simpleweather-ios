//
//  WeatherDetailsViewModel.swift
//  simpleweather
//
//  Created by Панов Сергей on 03.01.2024.
//

import Foundation
import RxSwift
import UIKit


class WeatherDetailsViewModel{
    private let repository = WeatherRepository()
    private let converter = WeatherConverter()
    private lazy var favouriteStorage = FavouriteStorage()
    
    let location:SearchEntityDto
    let isPreview:Bool
    
    init(location:SearchEntityDto, isPreview:Bool){
        self.location = location
        self.isPreview  = isPreview
    }
    
    func getWeather() -> Single<[RvItem]>{
        return repository.getWeatherFull(latitude: location.lat, lonitude:location.lon)
            .map { response in
                self.converter.createItemsList(response: response)
            }
            .observe(on: MainScheduler.instance)
            .do (onSuccess: { (s:[RvItem]) in
                print("s=\(s)"
                )
                
            }, onError: { Error in
                print("Error=\(Error)")
            })
    }
    
    func getToolbarRightIcon()->Observable<UIImage>{
        if !isPreview{
            return Observable.just(converter.createToolbarRightSettingsButton())
        }
        
        return favouriteStorage.isFavourite(locationId: location.id)
            .map { (isFavourite:Bool) in
                self.converter.createToolbarRightFavouriteButton(isFavourite: isFavourite)
            }
    }
    

    func onFavoriteIconClick(){
        favouriteStorage.changeFavouriteStatus(element: location)
    }
}
