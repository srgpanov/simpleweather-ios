//
//  ForecastViewController.swift
//  simpleweather
//
//  Created by Панов Сергей on 10.04.2025.
//

import UIKit

class ForecastViewController: UIViewController {

    private let viewModel = ForecastViewModel()
    private let tempBlock =     TempBlockView()
    private let  windBlock =     WindBlockView()
    private let  humidityBlock =     HumidityBlockView()
    private let  pressureBlock =     HumidityBlockView()
    private let  dayIndicatorBlock =     DayIndicatorBlockView()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        
        setupViews()
    }
    
    override func loadView() {
        let rootView = UIView()
        rootView.backgroundColor = UIColor.systemBackground
        rootView.addSubview(tempBlock)
        rootView.addSubview(windBlock)
        rootView.addSubview(humidityBlock)
        rootView.addSubview(pressureBlock)
        rootView.addSubview(dayIndicatorBlock)
        
        self.view=rootView
    }
    
    private func setupViews(){
        tempBlock.backgroundColor = .cyan
        dayIndicatorBlock.backgroundColor = .cyan
        
        setupHumidityBlock()
        setupPressureBlock()
        setupDayIndicatorBlock()
    }
    
    fileprivate func setupHumidityBlock() {
        humidityBlock.tvTitle.text = "forecast_humidity_title".asStringRes()
        humidityBlock.tvMorning.text = "70%"
        humidityBlock.tvDay.text = "40%"
        humidityBlock.tvEvening.text = "47%"
        humidityBlock.tvNight.text = "69%"
    }

    fileprivate func setupPressureBlock() {
        pressureBlock.tvTitle.text = "forecast_pressure_title".asStringRes(arguments: "мм рт. ст.")
        pressureBlock.tvMorning.text = "758"
        pressureBlock.tvDay.text = "758"
        pressureBlock.tvEvening.text = "757"
        pressureBlock.tvNight.text = "758"
    }
    
    fileprivate func setupDayIndicatorBlock() {
        dayIndicatorBlock.lineMoonPhase.tvLeft.text = "forecast_moon_phase".asStringRes()
        dayIndicatorBlock.lineWaterTemp.tvLeft.text = "forecast_temp_water".asStringRes()
        
        dayIndicatorBlock.lineMoonPhase.tvRight.text = "убывающая луна"
        dayIndicatorBlock.lineWaterTemp.tvRight.text = "15°"
    }
    
    private func setupConstraints(){
        tempBlock.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top )
            make.height.equalTo(132)
        }
        windBlock.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.top.equalTo(tempBlock.snp.bottom ).offset(12)
            make.height.equalTo(150)
        }
        humidityBlock.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.top.equalTo(windBlock.snp.bottom ).offset(12)
            make.height.equalTo(94)
        }
        pressureBlock.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.top.equalTo(humidityBlock.snp.bottom ).offset(12)
            make.height.equalTo(94)
        }
        dayIndicatorBlock.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.top.equalTo(pressureBlock.snp.bottom ).offset(12)
            make.height.equalTo(216)
        }
    }
}
