//
//  WeatherHourlyCell.swift
//  simpleweather
//
//  Created by Панов Сергей on 01.10.2023.
//

import Foundation
import UIKit

class WeatherHourlyCell : UICollectionViewCell {
    private static let imageSize = 32
    
    private let hourTimeLabel = UILabel()
    private let weatherIv = UIImageView()
    private let hourTempLabel = UILabel(frame: .zero)

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        contentView.translatesAutoresizingMaskIntoConstraints = false
        hourTimeLabel.numberOfLines = 0
        contentView.addSubview(hourTimeLabel)
        contentView.addSubview(weatherIv)
        contentView.addSubview(hourTempLabel)

        hourTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(4)
        }

        weatherIv.snp.makeConstraints { make in
            make.leading.equalTo(contentView)
            make.centerY.equalTo(contentView)
            make.size.equalTo(WeatherHourlyCell.imageSize)
        }
        hourTempLabel.snp.makeConstraints { make in
            make.bottom.leading.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.height.equalTo(WeatherHeaderCell.hourlyTableHeight)
        }
     
        
    }
    
    func bind(item:WeatherHourlyRvItem){
        hourTimeLabel.text = item.hourTime
        hourTempLabel.text = item.hourTemp
        weatherIv.image = UIImage(named: item.icon)
    }
    
}
