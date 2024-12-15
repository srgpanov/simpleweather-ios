//
//  RvViewHolder.swift
//  simpleweather
//
//  Created by Панов Сергей on 30.09.2023.
//

import Foundation

protocol RvViewHolder{

    func bind <T:RvItem> (item:T)
}
