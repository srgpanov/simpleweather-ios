//
//  SearchHistoryStorage.swift
//  simpleweather
//
//  Created by Панов Сергей on 01.12.2024.
//

import Foundation
import RxSwift


class SearchHistoryStorage{
    private var storage = UserDefaults.standard
    
    private static let KEY_SEARCH_HISTORY = "KEY_SEARCH_HISTORY"
    private static let MAX_HISTORY_LENGTH = 20
    
    
    func saveSearchElement(element:WeatherPlace){
        var currentSearchList:[SearchEntityDto] =  storage.readArray(forKey:  SearchHistoryStorage.KEY_SEARCH_HISTORY)
        currentSearchList = currentSearchList.filter { (item:SearchEntityDto) in
            element.id != item.id
        }
        currentSearchList.insert(SearchEntityDto(place: element), at: 0)
        currentSearchList=currentSearchList.take(count: SearchHistoryStorage.MAX_HISTORY_LENGTH )
        
        let currentList = currentSearchList.map { item in
            item.name + " \(item.id)"
        }
        print("SearchHistoryStorage \(currentList)")
        storage.saveArray(array: currentSearchList, forKey: SearchHistoryStorage.KEY_SEARCH_HISTORY)
    }
    
    func getSearchHistory() -> Observable<[WeatherPlace]>{
        return storage.observableArray(key:SearchHistoryStorage.KEY_SEARCH_HISTORY)
            .map { (dtos:[SearchEntityDto]) in
                dtos.map { dto in
                    dto.toWeatherPlace()
                }
            }
    }
    
    
}


extension UserDefaults {
    func observable<T>(key: String,defaultValue:T) -> Observable<T> {
        return Observable.create { observer in
            let userDefaults = UserDefaults.standard
            
            // Подписка на уведомления об изменении UserDefaults
            let notificationCenter = NotificationCenter.default
            
            if let initial = userDefaults.object(forKey: key) as? T{
                observer.onNext(initial)
            }else{
                observer.onNext(defaultValue)
            }
            
            
            let observerToken = notificationCenter.addObserver(forName: UserDefaults.didChangeNotification, object: userDefaults, queue: nil) { notification in
                // Каждый раз, когда значения в UserDefaults меняются, проверяем нужный ключ
                if let value = userDefaults.value(forKey: key) as? T {
                    observer.onNext(value)
                } else {
                    // Если значение отсутствует, передаем дефолтное значение
                    observer.onNext(defaultValue)
                }
            }
            
            return Disposables.create {
                notificationCenter.removeObserver(observerToken)
            }
        }
    }
    func observable<T:Codable>(objectType: T.Type,key: String, defaultValue:@escaping ()-> T) -> Observable<T> {
        return Observable.create { observer in
            let userDefaults = UserDefaults.standard
            
            // Подписка на уведомления об изменении UserDefaults
            let notificationCenter = NotificationCenter.default
            
             let initial = userDefaults.get(objectType: objectType, forKey: key) ?? defaultValue()
            observer.onNext(initial)
            
            
            let observerToken = notificationCenter.addObserver(forName: UserDefaults.didChangeNotification, object: userDefaults, queue: nil) { notification in
                // Каждый раз, когда значения в UserDefaults меняются, проверяем нужный ключ
                if let value = userDefaults.get(objectType: objectType, forKey: key)  {
                    observer.onNext(value)
                } else {
                    // Если значение отсутствует, передаем дефолтное значение
                    observer.onNext(defaultValue())
                }
            }
            
            return Disposables.create {
                notificationCenter.removeObserver(observerToken)
            }
        }
    }
}

extension UserDefaults {
    func observableArray(key: String) -> Observable<[SearchEntityDto]> {
        return Observable.create { observer in
            let userDefaults = UserDefaults.standard
            
            // Подписка на уведомления об изменении UserDefaults
            let notificationCenter = NotificationCenter.default
            
            let initial:[SearchEntityDto] = userDefaults.readArray(forKey: key)
            observer.onNext(initial)
            
            
            
            let observerToken = notificationCenter.addObserver(forName: UserDefaults.didChangeNotification, object: userDefaults, queue: nil) { notification in
                // Каждый раз, когда значения в UserDefaults меняются, проверяем нужный ключ
                let value:[SearchEntityDto] = userDefaults.readArray(forKey: key)
                observer.onNext(value)
                
            }
            
            return Disposables.create {
                notificationCenter.removeObserver(observerToken)
            }
        }
    }
}


extension UserDefaults {
    
    
    func set<T: Codable>(object: T, forKey: String)  {
        do{
            let jsonData = try JSONEncoder().encode(object)
            set(jsonData, forKey: forKey)
        } catch {
            fatalError()
        }
    }
    
    
    func get<T: Codable>(objectType: T.Type, forKey: String) -> T? {
        
        guard let result = value(forKey: forKey) as? Data else {
            return nil
        }
        
        do {
            return try JSONDecoder().decode(objectType, from: result)}
        catch {
            fatalError()
        }
    }
    
    
    
    func saveArray<T: Codable>(array: [T], forKey key: String) {
        do {
            let data:Data = try JSONEncoder().encode(array)
            set(data, forKey: key)
        } catch {
            print("Error encoding array: \(error)")
        }
    }
    
    func readArray<T: Codable>(forKey key: String) -> [T] {
        guard let data = data(forKey: key) else { return [] }
        do {
            return try JSONDecoder().decode([T].self, from: data)
        } catch {
            print("Error decoding array: \(error)")
            return []
        }
    }
}
