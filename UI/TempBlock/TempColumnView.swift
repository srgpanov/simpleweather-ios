//
//  TempColumnBlock.swift
//  simpleweather
//
//  Created by Панов Сергей on 10.04.2025.
//

import UIKit

class TempColumnView: UIView {

    let ivIcon = UIImageView()
    let tvCurrentTemp = UILabel()
    let tvFeelsLikeTemp = UILabel()
    

    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInnerViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private  func setupInnerViews() {
        addSubview(ivIcon)
        addSubview(tvCurrentTemp)
        addSubview(tvFeelsLikeTemp)
        
        let textSize:CGFloat = 12
        tvCurrentTemp.textSize = textSize
        tvFeelsLikeTemp.textSize = textSize
        
        ivIcon.image = UIImage(named: "ic_ovc")
        tvCurrentTemp.text = "13°"
        tvFeelsLikeTemp.text = "13°"
        tvFeelsLikeTemp.textColor = .lightGray
        
        tvCurrentTemp.backgroundColor = .white
        tvFeelsLikeTemp.backgroundColor = .cyan
    }
    
    private  func setupConstraints() {
        ivIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(32)
        }
        tvCurrentTemp.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(ivIcon.snp.bottom ).offset(12)
        }

        tvFeelsLikeTemp.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
