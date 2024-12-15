//
//  WeatherDetailCell.swift
//  simpleweather
//
//  Created by Панов Сергей on 15.10.2023.
//

import UIKit

class WeatherDetailCell: UICollectionViewCell {
    private static let imageSize = 16
    private static let valueMeasurementInset = -4
    private let windDirectionIv = UIImageView()
    private let pressureIv = UIImageView()
    private let humidityIv = UIImageView()
    
    private let windSpeedValueLabel = UILabel()
    private let windSpeedMeasureLabel = UILabel()
    private let windSpeedDirectionIv = UIImageView()
    private let pressureValueLabel = UILabel()
    private let pressureMeasureLabel = UILabel()
    private let humidityValueLabel = UILabel()
    private let humidityMeasureLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func bind(item:WeatherDetailRvItem){
        humidityValueLabel.text = item.humidity
        windSpeedValueLabel.text = item.windSpeedValue
        windSpeedMeasureLabel.text = item.windSpeed
        pressureValueLabel.text = item.pressureValue
        pressureMeasureLabel.text = item.pressureMeasurement
        humidityValueLabel.text = item.humidity
    }
    
    private func configure(){
        contentView.addSubview(windDirectionIv)
        contentView.addSubview(pressureIv)
        contentView.addSubview(humidityIv)
        
        contentView.addSubview(windSpeedValueLabel)
        contentView.addSubview(windSpeedMeasureLabel)
        contentView.addSubview(windSpeedDirectionIv)
        contentView.addSubview(pressureValueLabel)
        contentView.addSubview(pressureMeasureLabel)
        contentView.addSubview(humidityValueLabel)
        contentView.addSubview(humidityMeasureLabel)
        
        let imageInset=16
        windDirectionIv.snp.makeConstraints { make in
            make.size.equalTo(WeatherDetailCell.imageSize)
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(imageInset)
        }
        windDirectionIv.backgroundColor = .cyan
        pressureIv.backgroundColor = .cyan
        humidityIv.backgroundColor = .cyan

        pressureIv.snp.makeConstraints { make in
            make.size.equalTo(WeatherDetailCell.imageSize)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(imageInset)
        }
        humidityIv.snp.makeConstraints { make in
            make.size.equalTo(WeatherDetailCell.imageSize)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(imageInset)
        }
        
        let textsInsets = 40
        
        windSpeedValueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(textsInsets)
        }
        windSpeedMeasureLabel.snp.makeConstraints { make in
            make.leading.equalTo(windSpeedValueLabel.snp.trailing).inset(WeatherDetailCell.valueMeasurementInset)
            make.firstBaseline.equalTo(windSpeedValueLabel.snp.firstBaseline)
        }
        windSpeedDirectionIv.snp.makeConstraints { make in
            make.leading.equalTo(windSpeedMeasureLabel.snp.trailing)
            make.centerY.equalTo(windSpeedMeasureLabel.snp.centerY)
            make.size.equalTo(12)
        }
        
        pressureValueLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(textsInsets)
        }
        pressureMeasureLabel.snp.makeConstraints { make in
            make.leading.equalTo(pressureValueLabel.snp.trailing).inset(WeatherDetailCell.valueMeasurementInset)
            make.firstBaseline.equalTo(pressureValueLabel.snp.firstBaseline)
        }
        
        humidityValueLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(textsInsets)
        }
        humidityMeasureLabel.snp.makeConstraints { make in
            make.leading.equalTo(humidityValueLabel.snp.trailing).inset(WeatherDetailCell.valueMeasurementInset)
            make.firstBaseline.equalTo(humidityValueLabel.snp.firstBaseline)
        }

        humidityMeasureLabel.text = "%"
    }

}
