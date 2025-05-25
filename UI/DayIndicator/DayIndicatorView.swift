//
//  DayIndicatorView.swift
//  simpleweather
//
//  Created by Панов Сергей on 13.04.2025.
//

import UIKit

class DayIndicatorView: UIView {
    private let tvDayTimeDuration = createLabel()
    private let tvDayTimeDurationValue = createBoldLabel()
    private let stackTimeDuration = createStackView(spacing: 12)
    private let tvSunrise = createLabel()
    private let tvSunriseValue = createBoldLabel()
    private let stackSunrise = createStackView(spacing: 8)
    private let tvSunset = createLabel()
    private let tvSunsetValue = createBoldLabel()
    private let stackSunset = createStackView(spacing: 8)
    
    private let imageLayer = CAShapeLayer()
    private let textLayer = CATextLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayers()
    }
    
    
    private func setupView(){
        snp.makeConstraints { make in
            make.height.equalTo(snp.width).dividedBy(2.2)
        }
        
        backgroundColor = .blue.withAlphaComponent(0.5)
        
        
        addSubview(stackTimeDuration)
        addSubview(stackSunrise)
        addSubview(stackSunset)
        stackTimeDuration.addArrangedSubview(tvDayTimeDuration)
        stackTimeDuration.addArrangedSubview(tvDayTimeDurationValue)
        stackSunrise.addArrangedSubview(tvSunrise)
        stackSunrise.addArrangedSubview(tvSunriseValue)
        stackSunset.addArrangedSubview(tvSunset)
        stackSunset.addArrangedSubview(tvSunsetValue)
        
        
        tvDayTimeDuration.text = "day_indicator_duration".asStringRes()
        tvSunset.text = "day_indicator_sunset".asStringRes()
        tvSunrise.text = "day_indicator_sunrise".asStringRes()
    }
    
    func configure(model:ForecastUi.DayIndicatorUi.MoonPhaseUi){
        tvSunriseValue.text = model.sunrise
        tvSunsetValue.text = model.sunset
        tvDayTimeDurationValue.text = model.dayTime
    }
    
    private func setupLayers(){
        let path = UIBezierPath()
        
        let centerX = self.bounds.width/2
        let centerY = self.bounds.height/2
        let offset = 56.0
        let width = bounds.width-offset*2
        
        let start = CGPoint(x:offset,y:centerY)
        let end = CGPoint(x: start.x+width, y: start.y)
        path.move(to: start)
        path.addLine(to: end)
        
        
        let arcXOffset = 30.0
        let arcYOffset = 24.0
        let arcStart = CGPoint(x: start.x + arcXOffset, y: start.y - arcYOffset)
        let arcEnd = CGPoint(x: end.x - arcXOffset, y: start.y - arcYOffset)
        let arcRadius = (width - 16.0)/2
        let arcCenterY = 132.0
        
        //        path.move(to: arcStart)
        path.addArc(
            withCenter: CGPoint(x: centerX, y: arcCenterY) ,
            radius: arcRadius,
            //            startAngle: .pi * 210/180,
            //            endAngle: .pi * 330/180,
            
            startAngle: .pi * 180/180,
            endAngle: .pi * 360/180,
            clockwise: true
        )
        
        
        path.lineWidth = 5
        
        imageLayer.path = path.cgPath
        imageLayer.fillColor = UIColor.red.cgColor
        imageLayer.strokeColor = UIColor.red.cgColor
        layer.addSublayer(imageLayer)
    }
    
    private func         setupConstraints(){
        stackTimeDuration.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        stackSunrise.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        stackSunset.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    
    private static func createBoldLabel()->UILabel{
        let label = UILabel()
        
        
        return label
    }
    private static func createLabel()->UILabel{
        let label = UILabel()
        
        
        return label
    }
    
    private static func createStackView(spacing:CGFloat) -> UIStackView{
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = spacing
        
        return stack
    }
    
}
