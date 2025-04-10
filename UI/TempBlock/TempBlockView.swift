//
//  TempBlockView.swift
//  simpleweather
//
//  Created by Панов Сергей on 10.04.2025.
//

import UIKit

class TempBlockView: UIView {
    
    let morningTempColumn = TempColumnView()
    let dayTempColumn = TempColumnView()
    let eveningTempColumn = TempColumnView()
    let nightTempColumn = TempColumnView()
    
    let tvFellsLike = UILabel()
    
    private let feelsLikeGuide = UILayoutGuide()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInnerViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private  func setupInnerViews() {
        addSubview(morningTempColumn)
        addSubview(dayTempColumn)
        addSubview(eveningTempColumn)
        addSubview(nightTempColumn)
        addSubview(tvFellsLike)
        
        morningTempColumn.backgroundColor = .blue
        dayTempColumn.backgroundColor = .green
        eveningTempColumn.backgroundColor = .red
        nightTempColumn.backgroundColor = .yellow
        tvFellsLike.backgroundColor = .brown
        
        tvFellsLike.text = "forecast_feels_like".asStringRes()
        tvFellsLike.textSize = 12
        
    }
    
    private  func setupConstraints() {
        let views = [
            morningTempColumn,
            dayTempColumn,
            eveningTempColumn,
            nightTempColumn
        ]
        views.forEach { tempView            in
            tempView.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(12)
                make.bottom.equalToSuperview().inset(16)
                make.width.lessThanOrEqualToSuperview().dividedBy(views.count)
            }
        }
        
        
        morningTempColumn.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        
        dayTempColumn.snp.makeConstraints { make in
            make.leading.equalTo(morningTempColumn.snp.trailing).priority(.high)
        }
        
        eveningTempColumn.snp.makeConstraints { make in
            make.leading.equalTo(dayTempColumn.snp.trailing).priority(.high)
        }
        
        nightTempColumn.snp.makeConstraints { make in
            make.leading.equalTo(eveningTempColumn.snp.trailing).priority(.high)
            make.trailing.equalToSuperview()
        }
        
        addLayoutGuide(feelsLikeGuide)
        feelsLikeGuide.snp.makeConstraints { make in
            make.top.equalTo(morningTempColumn.tvCurrentTemp.snp.bottom)
            make.bottom.equalTo(morningTempColumn.tvFeelsLikeTemp.snp.top)
        }
        
        tvFellsLike.snp.makeConstraints { make in
            make.centerY.equalTo(feelsLikeGuide.snp.centerY)
            make.trailing.equalToSuperview().inset(16)
            make.leading.lessThanOrEqualToSuperview().inset(16)
        }
    }
}
