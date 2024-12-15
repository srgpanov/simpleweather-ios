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
    
    
    func search(query:String) -> Single<[SearchEntityDto]> {
        let apiUrl = "https://api.weatherapi.com/v1/search.json?q=\(query)&lang=ru&key=\(API_KEY)"
        return RxAlamofire.requestData(
            .get,
            apiUrl
        )
        .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
        .map { (response, data:Data)->[SearchEntityDto] in
            let decoder = JSONDecoder()
            
            print("response = \(String(data: data, encoding: String.Encoding.utf8))")
            
            return try decoder.decode([SearchEntityDto].self, from: data )
        }
        .asSingle()
       
    }
}
