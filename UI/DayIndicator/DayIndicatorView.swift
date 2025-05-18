//
//  DayIndicatorView.swift
//  simpleweather
//
//  Created by Панов Сергей on 13.04.2025.
//

import UIKit

class DayIndicatorView: UIView {
    
    private let imageLayer = CAShapeLayer()
    private let textLayer = CATextLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    private func setupView(){
        snp.makeConstraints { make in
            make.height.equalTo(snp.width).dividedBy(2.2)
        }
        
        backgroundColor = .blue.withAlphaComponent(0.5)
    }
    
    private func setupLayers(){
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x:50.0,y:50.0))
        path.addLine(to: CGPoint(x:50.0,y:60.0))
        path.lineWidth = 5
        
        imageLayer.path = path.cgPath
        imageLayer.fillColor = UIColor.red.cgColor
        imageLayer.strokeColor = UIColor.red.cgColor
        layer.addSublayer(imageLayer)
    }
    
}
