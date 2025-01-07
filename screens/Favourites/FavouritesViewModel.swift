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
    private let favouriteStorage = FavouriteStorage()
    private lazy var searchSource:Observable<[SearchEntityDto]> = getSearchStream()
    private lazy var favouriteSource:Observable<[SearchEntityDto]> = getFavouritesSource()
   private  lazy var s = observeSearchItemsClick()
    private var itemsClickDisposable: Disposable?
    
    

    
    func observeSearchItemsClick() ->Observable<SearchEntityDto>{
        return  elementClickSubject.withLatestFrom(searchSource){(index:Int,items:[SearchEntityDto]) in
            items[index]
        }
        .do(onNext: { (element: SearchEntityDto)in
            self.historyStorage.saveSearchElement(element: element)
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
    
    
    private func getSearchHistoryRvItems()->Observable<[SearchEntityDto]>{
        return historyStorage.getSearchHistory()
    }
    
    
    private func getSearchStream() -> Observable<[SearchEntityDto]>{
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
    
    private func getFavouritesSource() -> Observable<[SearchEntityDto]> {
        return favouriteStorage.getFavouriteElements()
            .replay(1)
            .refCount()
    }
    private func getFavouritesItems()->Observable<[RvItem]> {
        return favouriteSource.map {   items in
              self.converter.createFavouriteItemsList(favourites: items)
        }
    }
    
    
    private func getSearchQueryItems(query:String)-> Observable<[SearchEntityDto]>{
        return   Observable<Int>.timer(RxTimeInterval.milliseconds(300), period: nil,scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap {_ in
                self.repository.search(query: query)
                    .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            }
        
            .observe(on: MainScheduler.instance)
            .asObservable()
    }
    
    
    
    func onTextItemClick(index:Int,item:TextRvItem){
        elementClickSubject.onNext(index)
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
    }
    
    deinit{
        itemsClickDisposable?.dispose()
    }
    
}
