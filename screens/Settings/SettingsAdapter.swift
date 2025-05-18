//
//  SettingsAdapter.swift
//  simpleweather
//
//  Created by Панов Сергей on 10.03.2024.
//

import Foundation
import UIKit


class SettingsAdapter:NSObject, UITableViewDataSource, UITableViewDelegate{
    private var items:[RvItem] = []
    private let listerner:(SettingsSwitchRvItem, Bool) -> Void
    
    init(listener: @escaping ( SettingsSwitchRvItem,Bool) -> Void) {
        self.listerner = listener
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = items[indexPath.item]
        
        switch item {
        case _ as SettingsSwitchRvItem :
           
            return CGFloat(48)
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        
        let viewHolder:UITableViewCell
        switch item {
        case let item as SettingsSwitchRvItem :
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsSwitchRvItem.identifier) as! SettingsSwitchCell
            
            cell.contentView.setOnClickListener {
                self.listerner(item, cell.switchView.isOn)
            }
            cell.bind(item:item )
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
