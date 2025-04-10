//
//  WeatherAdapter.swift
//  simpleweather
//
//  Created by Панов Сергей on 29.09.2023.
//

import Foundation
import UIKit

class WeatherAdapter : NSObject, UITableViewDataSource,UITableViewDelegate {
    private var items:[RvItem] = []
    var forecastClickListener : ()->Void = {}
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        
        let viewHolder:UITableViewCell
        switch item {
        case let item as WeatherHeaderRvItem :
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherHeaderRvItem.identifier) as! WeatherHeaderCell
            cell.bind(item:item )
            viewHolder = cell
        case let item as WeatherDayRvItem :
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDayRvItem.identifier) as! WeatherDayCell
            cell.bind(item:item )
            cell.contentView.setOnClickListener(action: forecastClickListener)
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
