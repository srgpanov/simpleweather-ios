//
//  WeatherDayCellTableViewCell.swift
//  simpleweather
//
//  Created by Панов Сергей on 08.10.2023.
//

import UIKit

class WeatherDayCell: UITableViewCell {
    private let dateLabel = UILabel()
    private let dayWeekLabel = UILabel()
    private let weatherImageView = UIImageView()
    private let dayTempLabel = UILabel()
    private let nightTempLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: WeatherDayRvItem.self.identifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
        }
        dayWeekLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalTo(dateLabel.snp.leading)
            make.top.equalTo(dateLabel.snp.bottom).offset(4)
        }
        
        nightTempLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.equalTo(36)
        }
        dayTempLabel.snp.makeConstraints { make in
            make.trailing.equalTo(nightTempLabel.snp.leading ).offset(-16)
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
        }
        weatherImageView.snp.makeConstraints { make in
            make.trailing.equalTo(dayTempLabel.snp.leading ).offset(-16)
            make.centerY.equalToSuperview()
            make.size.equalTo(32)
        }
    }
    
    func configure(){
        contentView.addSubview(dateLabel)
        contentView.addSubview(dayWeekLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(dayTempLabel)
        contentView.addSubview(nightTempLabel)
        
        
        setupConstraints()
        
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dayWeekLabel.font = UIFont.systemFont(ofSize: 16)
        
        nightTempLabel.textAlignment = .right
        dayTempLabel.textAlignment = .right
    }
    
    
    
    func bind(item:WeatherDayRvItem){
        dateLabel.text=item.date
        dayWeekLabel.text=item.dayWeek
        dayTempLabel.text=item.tempDay
        nightTempLabel.text=item.tempNight
        weatherImageView.image = UIImage(named: item.icon)
    }
    
}
