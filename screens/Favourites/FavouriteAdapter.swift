//
//  FavouriteAdapter.swift
//  simpleweather
//
//  Created by Панов Сергей on 27.10.2024.
//

import Foundation
import UIKit


class FavouriteAdapter :NSObject, UITableViewDataSource,UITableViewDelegate {
    
    
    var onFavouriteClick:((FavouriteRvItem)->Void )?
    var onTextClick:((Int, TextRvItem)->Void )?
    var onCustomLocationClick: (() -> Void)?
    var onGeoLocationClick: (() -> Void)?
    
    private var items:[RvItem] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = items[indexPath.item]
        
        switch item {
        case _ as TextRvItem :
           
            return CGFloat(32)
        case _ as FavouriteRvItem :
            return CGFloat(100)
            
        case _ as UserLocationRvItem :
            return CGFloat(48)
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        
        let viewHolder:UITableViewCell
        switch item {

        case let item as TextRvItem :
            let cell = tableView.dequeueReusableCell(withIdentifier: TextRvItem.identifier) as! TextCell
            cell.bind(item:item )
            guard let click = onTextClick else {fatalError()}
            cell.contentView.setOnClickListener {
                click(indexPath.item,item)
            }
            
            viewHolder = cell
            
        case let item as FavouriteRvItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteRvItem.identifier) as! FavouriteCell
            cell.bind(item:item )
            guard let click = onFavouriteClick else {fatalError()}
            cell.contentView.setOnClickListener {
                click(item)
            }
            viewHolder = cell
            
        case let item as UserLocationRvItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: UserLocationRvItem.identifier) as! UserLocationCell
            cell.bind(item:item )
            cell.onGeoLocationClick = onGeoLocationClick
            cell.onCustomLocationClick = onCustomLocationClick
            viewHolder = cell
            
        default:
            fatalError()
        }
        
        return viewHolder
    }
    


    
    func setItems(items:[RvItem]){
        self.items = items

    }
}
