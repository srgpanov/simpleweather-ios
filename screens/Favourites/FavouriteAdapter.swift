//
//  FavouriteAdapter.swift
//  simpleweather
//
//  Created by Панов Сергей on 27.10.2024.
//

import Foundation
import UIKit


class FavouriteAdapter :NSObject, UITableViewDataSource,UITableViewDelegate {
    
    
    var onItemClick:(Int,RvItem)->Void = {(index,item) in
        print(index)
    }
    
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
            viewHolder = cell
            
        case let item as FavouriteRvItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteRvItem.identifier) as! FavouriteCell
            cell.bind(item:item )
            viewHolder = cell
        default:
            fatalError()
        }
        
        return viewHolder
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rvItem =        items[indexPath.item]
        onItemClick( indexPath.item ,rvItem)
       
    }

    
    func setItems(items:[RvItem]){
        self.items = items

    }
}
