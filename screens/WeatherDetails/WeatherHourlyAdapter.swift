//
//  WeatherHourlyAdapter.swift
//  simpleweather
//
//  Created by Панов Сергей on 01.10.2023.
//

import Foundation
import UIKit

class WeatherHourlyAdapter : NSObject, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    
    private var items:[RvItem] = [    ]
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        
        switch item {
        case let item as WeatherHourlyRvItem :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherHourlyRvItem.identifier, for: indexPath) as! WeatherHourlyCell
            cell.bind(item:item )
            return cell
        case let item as WeatherDetailRvItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherDetailRvItem.identifier, for: indexPath) as! WeatherDetailCell
            cell.bind(item:item )
            return cell
        default:
            fatalError()
        }
    }
    
    func setItems(items:[RvItem]){
        self.items = items
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = items[indexPath.item]
        
        switch item {
        case _ as WeatherHourlyRvItem :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherHourlyRvItem.identifier, for: indexPath) as! WeatherHourlyCell
                  // Установить размеры ширины на основе контента ячейки
                  cell.setNeedsLayout()
                  cell.layoutIfNeeded()
            let size:CGSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            let width:Int = Int(size.width)
            
            return CGSize(width:width, height: WeatherHeaderCell.hourlyTableHeight)
        case _ as WeatherDetailRvItem :
            return CGSize(width: 200, height: WeatherHeaderCell.hourlyTableHeight)
        default:
            fatalError()
        }
        
    }
}
