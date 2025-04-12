//
//  DayIndicatorLineView.swift
//  simpleweather
//
//  Created by Панов Сергей on 13.04.2025.
//

import UIKit

class DayIndicatorLineView: UIView {

let tvLeft = UILabel()
let tvRight = UILabel()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInnerViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInnerViews(){
        addSubview(tvLeft)
        addSubview(tvRight)
        
        tvLeft.backgroundColor = .blue
        tvRight.backgroundColor = .green
        
    }
    
    private func setupConstraints(){
        tvLeft.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalTo(self.snp.centerX)
        }
        tvRight.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.centerX )
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
