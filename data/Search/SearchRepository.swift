//
//  SearchRepository.swift
//  simpleweather
//
//  Created by Панов Сергей on 17.11.2024.
//

import Foundation
import RxSwift
import RxAlamofire


class SearchRepository{
    
    
    func search(query:String) -> Single<[WeatherPlace]> {
        let apiUrl = "https://api.weatherapi.com/v1/search.json?q=\(query)&lang=ru&key=\(API_KEY)"
        return RxAlamofire.requestData(
            .get,
            apiUrl
        )
        .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
        .map { (response, data:Data)->[WeatherPlace] in
            let decoder = JSONDecoder()
            
            return try decoder.decode([SearchEntityDto].self, from: data )
                .map { dto in
                    dto.toWeatherPlace()
                }
        }
        .asSingle()
       
    }
}


extension SearchEntityDto{
    func toWeatherPlace() -> WeatherPlace{
        return WeatherPlace(
            id: self.id,
            geoLocation: GeoLocation(latitude: self.lat, longitude: self.lon),
            name: self.name,
            country:self.country,
            region: self.region
        )
    }
}
