//
//  HumidityBlockView.swift
//  simpleweather
//
//  Created by Панов Сергей on 10.04.2025.
//

import UIKit

class HumidityBlockView: UIView {

    let tvTitle = UILabel()
    let tvMorning = UILabel()
    let tvDay = UILabel()
    let tvEvening = UILabel()
    let tvNight = UILabel()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInnerViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private  func setupInnerViews() {
        addSubview(tvTitle)
        addSubview(tvMorning)
        addSubview(tvDay)
        addSubview(tvEvening)
        addSubview(tvNight)
        
        let textSize:CGFloat = 12
        tvMorning.textSize = textSize
        tvDay.textSize = textSize
        tvEvening.textSize = textSize
        tvNight.textSize = textSize
        
        
        tvMorning.textAlignment = .center
        tvDay.textAlignment = .center
        tvEvening.textAlignment = .center
        tvNight.textAlignment = .center
        
        tvMorning.backgroundColor = .blue
        tvDay.backgroundColor = .green
        tvEvening.backgroundColor = .red
        tvNight.backgroundColor = .yellow
        backgroundColor = .cyan
        tvTitle.backgroundColor = .brown
        
    }
    
    private  func setupConstraints() {
        tvTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().inset(16)
            make.trailing.lessThanOrEqualToSuperview()
        }
        let views = [
            tvMorning,
            tvDay,
            tvEvening,
            tvNight
        ]
        views.forEach { make            in
            make.snp.makeConstraints { make in
                make.top.equalTo(tvTitle.snp.bottom ).offset(24)
                make.bottom.equalToSuperview().inset(16)
                make.width.lessThanOrEqualToSuperview().dividedBy(views.count)
            }
        }
        
        tvMorning.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        
        tvDay.snp.makeConstraints { make in
            make.leading.equalTo(tvMorning.snp.trailing).priority(.high)
        }
        tvEvening.snp.makeConstraints { make in
            make.leading.equalTo(tvDay.snp.trailing).priority(.high)
        }
        tvNight.snp.makeConstraints { make in
            make.leading.equalTo(tvEvening.snp.trailing).priority(.high)
            make.trailing.equalToSuperview()
        }

    }
}
