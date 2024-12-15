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
    
    
    func saveSearchElement(element:SearchEntityDto){
        var currentSearchList:[SearchEntityDto] =  storage.readArray(forKey:  SearchHistoryStorage.KEY_SEARCH_HISTORY)
       currentSearchList = currentSearchList.filter { (item:SearchEntityDto) in
           element.id != item.id 
        }
        currentSearchList.insert(element, at: 0)
        currentSearchList=currentSearchList.take(count: SearchHistoryStorage.MAX_HISTORY_LENGTH )
        
        let currentList = currentSearchList.map { item in
            item.name + " \(item.id)"
        }
        print("SearchHistoryStorage \(currentList)")
        storage.saveArray(array: currentSearchList, forKey: SearchHistoryStorage.KEY_SEARCH_HISTORY)
    }
    
    func getSearchHistory() -> Observable<[SearchEntityDto]>{
        return storage.observableArray(key:SearchHistoryStorage.KEY_SEARCH_HISTORY)
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


    func set<T: Codable>(object: T, forKey: String) throws {

        let jsonData = try JSONEncoder().encode(object)

        set(jsonData, forKey: forKey)
    }


    func get<T: Codable>(objectType: T.Type, forKey: String) throws -> T? {

        guard let result = value(forKey: forKey) as? Data else {
            return nil
        }

        return try JSONDecoder().decode(objectType, from: result)
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
