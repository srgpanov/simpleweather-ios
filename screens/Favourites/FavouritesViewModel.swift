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
    private let repository = SearchRepository()
    private let converter = FavouriteConverter()
    private let storage = SearchHistoryStorage()
    private lazy var searchSource:Observable<[SearchEntityDto]> = getSearchStream()
   private  lazy var s = observeSearchItemsClick()
    private var itemsClickDisposable: Disposable?
    
    
    init (){
        itemsClickDisposable = observeSearchItemsClick()
    }
    
    func observeSearchItemsClick() ->Disposable{
        return  elementClickSubject.withLatestFrom(searchSource){(index:Int,items:[SearchEntityDto]) in
            items[index]
        }
                 .subscribe(onNext: { (element: SearchEntityDto)in
                     print("onNext= elements=\(element)")
                     self.storage.saveSearchElement(element: element)
                 })
    }
    
    func getItemsStream() -> Observable<[RvItem]>{
        return  searchSource    .map { items in
            self.converter.createSearchItemsList(searchResponse: items)
        }
    }
    
    
    private func getSearchHistoryRvItems()->Observable<[SearchEntityDto]>{
        return storage.getSearchHistory()
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
    
    private func getSearchQueryItems(query:String)-> Observable<[SearchEntityDto]>{
        return   Observable<Int>.timer(RxTimeInterval.milliseconds(300), period: nil,scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap {_ in
                self.repository.search(query: query)
                    .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            }
        
            .observe(on: MainScheduler.instance)
            .asObservable()
    }
    
    
    
    func onItemClick(index:Int,item:RvItem){
        let text = item as! TextRvItem
        print("onItemClick text=\(text.text ) index=\(index)")
        elementClickSubject.onNext(index)
        
    }
    
    func onSearchItemClick(searchItem:String){
        
        searchSubject.onNext(searchItem)
    }
    
    
    func onSearchQueryChanged(query:String){
        searchSubject.onNext(query)
    }
    
    deinit{
        itemsClickDisposable?.dispose()
    }
    
}
