//
//  WindColumnView.swift
//  simpleweather
//
//  Created by Панов Сергей on 10.04.2025.
//

import UIKit

class WindColumnView: UIView {
    let tvWindSpeed = UILabel()
    let ivDirection = UIImageView()
    let tvDirection = UILabel()
    let tvWindGust = UILabel()
    
    let containerWindDirection = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInnerViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private  func setupInnerViews() {
        addSubview(tvWindSpeed)
        addSubview(containerWindDirection)
        containerWindDirection.addSubview(ivDirection)
        containerWindDirection.addSubview(tvDirection)
        addSubview(tvWindGust)
        
        let textSize:CGFloat = 12
        tvDirection.textSize = textSize
        tvWindSpeed.textSize = textSize
        tvWindGust.textSize = textSize
        
        ivDirection.image = UIImage(named: "ic_ovc")
        tvDirection.text = "4"
        tvWindSpeed.text = "В"
        tvWindGust.text = "до 8"
        
    }
    
    private  func setupConstraints() {
        tvWindSpeed.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        containerWindDirection.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tvWindSpeed.snp.bottom).offset(10)
        }
        ivDirection.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.size.equalTo(16 )
        }
        tvDirection.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.leading.equalTo(ivDirection.snp.trailing)
            make.centerY.equalToSuperview()
        }


        tvWindGust.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

}
