//
//  ForecastViewController.swift
//  simpleweather
//
//  Created by Панов Сергей on 10.04.2025.
//

import UIKit
import RxSwift

class ForecastViewController: UIViewController {

    private let viewModel = ForecastViewModel()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let tempBlock =     TempBlockView()
    private let  windBlock =     WindBlockView()
    private let  humidityBlock =     HumidityBlockView()
    private let  pressureBlock =     HumidityBlockView()
    private let  dayIndicatorBlock =     DayIndicatorBlockView()
    private let bag = DisposeBag()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        

        bindViewModel()
    }
    
    override func loadView() {
        let rootView = UIView()
        rootView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.backgroundColor = UIColor.systemBackground
        contentView.addSubview(tempBlock)
        contentView.addSubview(windBlock)
        contentView.addSubview(humidityBlock)
        contentView.addSubview(pressureBlock)
        contentView.addSubview(dayIndicatorBlock)
        
        
        tempBlock.asCardView()
        windBlock.asCardView()
        humidityBlock.asCardView()
        pressureBlock.asCardView()
        dayIndicatorBlock.asCardView()

        
        self.view=rootView
    }
    
    func bindViewModel(){
        viewModel.dayForecastUi
            .subscribe { (model:ForecastUi) in
                self.setupHumidityBlock(humidity: model.humidity)
                self.setupPressureBlock(pressure: model.pressure)
                self.setupTempBlock(temp:model.temp)
                self.setupDayIndicatorBlock(model: model.dayIndicator)
            }
            .disposed(by: bag)

    }

    
    
    private func setupTempBlock (temp:ForecastUi.DayTempUi){
        tempBlock.morningTempColumn.tvCurrentTemp.text = temp.morning
        tempBlock.dayTempColumn.tvCurrentTemp.text = temp.day
        tempBlock.eveningTempColumn.tvCurrentTemp.text = temp.evening
        tempBlock.nightTempColumn.tvCurrentTemp.text = temp.night
        
    }
    fileprivate func setupHumidityBlock(humidity:ForecastUi.DayHumidityUi) {
        humidityBlock.tvTitle.text = "forecast_humidity_title".asStringRes()
        humidityBlock.tvMorning.text = humidity.morning
        humidityBlock.tvDay.text = humidity.day
        humidityBlock.tvEvening.text = humidity.evening
        humidityBlock.tvNight.text = humidity.night
    }

    fileprivate func setupPressureBlock(pressure:ForecastUi.DayPressureUi) {
        pressureBlock.tvTitle.text = "forecast_pressure_title".asStringRes(arguments:pressure.measurements)
        pressureBlock.tvMorning.text = pressure.morning
        pressureBlock.tvDay.text = pressure.day
        pressureBlock.tvEvening.text = pressure.evening
        pressureBlock.tvNight.text = pressure.night
    }
    
    fileprivate func setupDayIndicatorBlock(model : ForecastUi.DayIndicatorUi) {

//        var sunrise = DateComponents()
//        sunrise.hour = 5
//        sunrise.minute = 32
//        
//        var sunset = DateComponents()
//        sunset.hour = 19
//        sunset.minute = 13
//        
//        let model = DayIndicatorUi(
//            moonPhaseIndicator: DayIndicatorUi.MoonPhaseUi(sunrise: sunrise, sunset: sunset, dayTime: "13 ч 41 мин"),
//            moonPhaseLine: DayIndicatorUi.DayIndicatorLine(left: "forecast_moon_phase".asStringRes(), right: "убывающая луна"),
//            waterTempLine: DayIndicatorUi.DayIndicatorLine(left: "forecast_temp_water".asStringRes(), right: "15°")
//        )
        dayIndicatorBlock.configure(model: model)
    }
    
    private func setupConstraints(){
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        tempBlock.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.top.equalTo(contentView.snp.top )
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
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
    }
}
