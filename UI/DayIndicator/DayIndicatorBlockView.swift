//
//  DayIndicatorBlockView.swift
//  simpleweather
//
//  Created by Панов Сергей on 13.04.2025.
//

import UIKit

class DayIndicatorBlockView: UIView {

    let lineMoonPhase = DayIndicatorLineView()
    let lineWaterTemp = DayIndicatorLineView()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInnerViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInnerViews(){
        addSubview(lineMoonPhase)
        addSubview(lineWaterTemp)
        
        lineMoonPhase.backgroundColor = .yellow
        lineWaterTemp.backgroundColor = .yellow
    }
    
    private func setupConstraints(){
        lineMoonPhase.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalTo(lineWaterTemp.snp.top)
            make.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        lineWaterTemp.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
    }
}
