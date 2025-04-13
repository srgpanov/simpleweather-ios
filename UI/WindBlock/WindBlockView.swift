//
//  WindBlockView.swift
//  simpleweather
//
//  Created by Панов Сергей on 10.04.2025.
//

import UIKit

class WindBlockView: UIView {
    let tvWind = UILabel()
    let morningWindColumn = WindColumnView()
    let dayWindColumn = WindColumnView()
    let eveningWindColumn = WindColumnView()
    let nightWindColumn = WindColumnView()
    let tvGust = UILabel()
    
    private let gustGuideLine = UILayoutGuide()
      
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInnerViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private  func setupInnerViews() {
        addSubview(tvWind)
        addSubview(morningWindColumn)
        addSubview(dayWindColumn)
        addSubview(eveningWindColumn)
        addSubview(nightWindColumn)
        addSubview(tvGust)
        
        
        
        
        tvGust.textSize = 12
        tvWind.text = "forecast_wind_speed".asStringRes(arguments: "м/с")
        tvGust.text = "forecast_wind_gust".asStringRes()
    }
    
    private  func setupConstraints() {
        tvWind.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().inset(16)
            make.trailing.lessThanOrEqualToSuperview()
        }
        let views = [
            morningWindColumn,
            dayWindColumn,
            eveningWindColumn,
            nightWindColumn
        ]
        views.forEach { make            in
            make.snp.makeConstraints { make in
                make.top.equalTo(tvWind.snp.bottom ).offset(24)
                make.bottom.equalToSuperview().inset(16)
                make.width.lessThanOrEqualToSuperview().dividedBy(views.count)
            }
        }
        
        
        morningWindColumn.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        
        dayWindColumn.snp.makeConstraints { make in
            make.leading.equalTo(morningWindColumn.snp.trailing).priority(.high)
        }
        eveningWindColumn.snp.makeConstraints { make in
            make.leading.equalTo(dayWindColumn.snp.trailing).priority(.high)
        }
        nightWindColumn.snp.makeConstraints { make in
            make.leading.equalTo(eveningWindColumn.snp.trailing).priority(.high)
            make.trailing.equalToSuperview()
        }
        
        addLayoutGuide(gustGuideLine)
        gustGuideLine.snp.makeConstraints { make in
            make.top.equalTo(morningWindColumn.containerWindDirection.snp.bottom)
            make.bottom.equalTo(morningWindColumn.tvWindGust.snp.top)
        }
        
        tvGust.snp.makeConstraints { make in
            make.centerY.equalTo(gustGuideLine.snp.centerY)
            make.trailing.equalToSuperview().inset(16)
            make.leading.lessThanOrEqualToSuperview().inset(16)
        }
    }

}
