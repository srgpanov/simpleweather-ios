//
//  UserLocationCell.swift
//  simpleweather
//
//  Created by Панов Сергей on 08.04.2025.
//

import Foundation
import UIKit


class UserLocationCell:UITableViewCell{
    let itCustomLocation = IconTextView()
    let itGeoLocation = IconTextView()
    
    var onCustomLocationClick: (() -> Void)?
    var onGeoLocationClick: (() -> Void)?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: UserLocationRvItem.self.identifier)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func bind(item:UserLocationRvItem){
        itCustomLocation.setText(text:  item.customLocationText)
        itCustomLocation.setIcon(iconId:  item.customLocationIcon)
        itGeoLocation.setText(text:  item.geoPositionLocationText)
        itGeoLocation.setIcon(iconId:  item.geoPositionLocationIcon)
    }
    
    private func configure(){
        contentView.addSubview(itCustomLocation)
        contentView.addSubview(itGeoLocation)

        contentView.backgroundColor = .cyan
        
        itCustomLocation.backgroundColor = .red
        itGeoLocation.backgroundColor = .red
        
        
        setupConstraints()
        
        setupClickHandlers()
    }
    
    
    private func setupConstraints(){
        itCustomLocation.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.lessThanOrEqualTo(snp.centerX).offset(-16)
            make.height.equalToSuperview()
        }

        itGeoLocation.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(snp.centerX).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalToSuperview()
        }

    }
    
    private func setupClickHandlers() {
        itCustomLocation.setOnClickListener {
            guard let click = self.onCustomLocationClick else {fatalError()}
            click()
        }
        itGeoLocation.setOnClickListener {
            guard let click = self.onGeoLocationClick else {fatalError()}
            click()
        }

    }

}
