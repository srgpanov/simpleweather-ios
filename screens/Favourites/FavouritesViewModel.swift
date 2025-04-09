//
//  FavouritesViewModel.swift
//  simpleweather
//
//  Created by Панов Сергей on 27.10.2024.
//

import UIKit
import RxSwift

class FavouritesViewModel {
    
    private let searchSubject = PublishSubject<String>()
    private let elementClickSubject = PublishSubject<Int>()
    private let searchBarIsVisible = BehaviorSubject<Bool>(value: false)
    private let repository = SearchRepository()
    private let converter = FavouriteConverter()
    private let historyStorage = SearchHistoryStorage()
    private let settingStorage = SettingsStorage()
    private let favouriteStorage = FavouriteStorage()
    private lazy var searchSource:Observable<[WeatherPlace]> = getSearchStream()
    private lazy var favouriteSource:Observable<[WeatherPlace]> = getFavouritesSource()
    private  lazy var s = observeSearchItemsClick()
    private var itemsClickDisposable: Disposable?
    private var isCurrentLocationSelect = false
    
    
    
    
    func observeSearchItemsClick() ->Observable<SearchClickCortege>{
        return  elementClickSubject.withLatestFrom(searchSource){(routerId:Int,items:[WeatherPlace]) in
            let place = items.first { dto in
                dto.id==routerId
            }!
            
            return SearchClickCortege(isCurrentLocationSelect: self.isCurrentLocationSelect, place:  place)
        }
        .do(onNext: { (element: SearchClickCortege) in
            self.historyStorage.saveSearchElement(element: element.place)
            
            print("isCurrentLocationSelect=\(self.isCurrentLocationSelect)")
            if self.isCurrentLocationSelect {
                self.settingStorage.setCurrentLocation(place: element.place )
            }
        })
    }

    
    func getItemsStream() -> Observable<[RvItem]>{
        return  searchBarIsVisible.flatMapLatest { isVisible in
            if isVisible {
                self.searchSource    .map { items in
                    self.converter.createSearchItemsList(searchResponse: items)
                }
            } else {
                self.getFavouritesItems()
            }
        }
        
        
    }
    
    
    private func getSearchHistoryRvItems()->Observable<[WeatherPlace]>{
        return historyStorage.getSearchHistory()
    }
    
    
    private func getSearchStream() -> Observable<[WeatherPlace]>{
        return searchSubject.flatMapLatest { (query:String) in
            if query.isEmpty {
                self.getSearchHistoryRvItems()
            } else {
                self.getSearchQueryItems(query: query)
            }
        }
        .do(onSubscribe: {
            print("getSearchStream onSubscribe")
        })
        .replay(1)
        .refCount()
    }
    
    private func getFavouritesSource() -> Observable<[WeatherPlace]> {
        return favouriteStorage.getFavouriteElements()
            .replay(1)
            .refCount()
    }
    
    private func getCurrentLocation()->Observable<WeatherPlace> {
        return settingStorage.getCurrentLocationStream()

    }
    
    
    private func getFavouritesItems()->Observable<[RvItem]> {
        return Observable.combineLatest(getCurrentLocation(), favouriteSource) { current,  favourites in
            let current = self.converter.createCurrentItemsList(current:current)
           let favourites = self.converter.createFavouriteItemsList(favourites: favourites)
           return current + favourites
        }
    }
    
    
    private func getSearchQueryItems(query:String)-> Observable<[WeatherPlace]>{
        return   Observable<Int>.timer(RxTimeInterval.milliseconds(300), period: nil,scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap {_ in
                self.repository.search(query: query)
                    .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            }
        
            .observe(on: MainScheduler.instance)
            .asObservable()
    }
    
    
    
    func onTextItemClick(index:Int,item:TextRvItem){
        elementClickSubject.onNext(item.routerId)
        
    }
    func onCustomLocationClick(){
        isCurrentLocationSelect = true
    }
    func onGeoLocationClick(){
        
    }
    
    func onFavoriteItemClick(index:Int,item:FavouriteRvItem){
        print("onFavoriteItemClick")
        
    }
    
    func onSearchItemClick(searchItem:String){
        
        searchSubject.onNext(searchItem)
    }
    
    
    func onSearchQueryChanged(query:String){
        searchSubject.onNext(query)
    }
    
    func onSearchBarrHidden(isActive:Bool){
        searchBarIsVisible.onNext(isActive)
        if !isActive {
            isCurrentLocationSelect = false
        }
    }
    
    deinit{
        itemsClickDisposable?.dispose()
    }
    
}
