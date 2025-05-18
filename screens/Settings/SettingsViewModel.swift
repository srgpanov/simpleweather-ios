//
//  SettingsViewModel.swift
//  simpleweather
//
//  Created by Панов Сергей on 10.03.2024.
//

import UIKit
import RxSwift

class SettingsViewModel {
    
    private let storage = MeasurementsStorage()
    private let clickSubject = PublishSubject<KeyValue>()
    private let measurementsSource:Observable<Measurements>
    let itemsList:Observable<[RvItem]>
    private let bag  = DisposeBag()

    
    
    init(){
        measurementsSource =   clickSubject.scan(storage.load(), accumulator: {(acc,event) in
            var neeAcc = acc
            switch event.name{
            case "temp":
                if acc.temp == .CELSIUS {
                    neeAcc.temp = .FARINGHEIT
                }else{
                    neeAcc.temp = .CELSIUS
                }
               
            case "windSpeed":
                if acc.windSpeed == .M_S {
                    neeAcc.windSpeed = .KM_H
                }else{
                    neeAcc.windSpeed = .M_S
                }
            case "pressure":
                if acc.pressure == .MM_OF_MERCURY {
                    neeAcc.pressure = .H_PA
                }else{
                    neeAcc.pressure  = .MM_OF_MERCURY
                }
            default:fatalError()
            }
            
            return neeAcc
        }
        )
        .startWith(storage.load())
        .replay(1)
        .refCount()
        
        
        itemsList = measurementsSource.map { Measurements in
       
            return [
                SettingsSwitchRvItem(routerId: 1, isTurnOn: Measurements.temp != .CELSIUS, text: "settings_temp".asStringRes()),
                SettingsSwitchRvItem(routerId: 2,isTurnOn: Measurements.windSpeed != .M_S, text: "settings_speed".asStringRes()),
                SettingsSwitchRvItem(routerId: 3,isTurnOn: Measurements.pressure != .MM_OF_MERCURY, text: "settings_pressure".asStringRes()),
            ]
        }
        measurementsSource.subscribe { Measurements in
            self.storage.save(measurements: Measurements)
       }
        .disposed(by: bag)


        
    }
    
    func onSwitchClick(item:SettingsSwitchRvItem,isTurnOn:Bool){
        switch item.routerId{
        case 1:
            clickSubject.onNext(KeyValue(name: "temp", isTurnOn: isTurnOn))
        case 2:
            clickSubject.onNext(KeyValue(name: "windSpeed", isTurnOn: isTurnOn))
        case 3:
            clickSubject.onNext(KeyValue(name: "pressure", isTurnOn: isTurnOn))
        default:
            fatalError()
        }
    }
    
    
    
    
    private struct KeyValue{
        let name:String
        let isTurnOn:Bool
    }
}
