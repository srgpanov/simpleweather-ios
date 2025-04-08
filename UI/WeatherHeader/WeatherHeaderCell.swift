//
//  WeatherHeaderCell.swift
//  simpleweather
//
//  Created by Панов Сергей on 29.09.2023.
//

import Foundation
import UIKit

class WeatherHeaderCell : UITableViewCell{
    private static let topOffset = 88
    private static let imageSize = 72
    private static let textColor = UIColor.black
    static let hourlyTableHeight = 180
    private var myLayer:CAGradientLayer?=nil
    
    private let conditionLabel = {
        let label =   UILabel()
        label.font=label.font.withSize(18)
        label.textColor = textColor
        return label
    }()
    private let feelsLikeLabel = {
        let label =   UILabel()
        label.font=label.font.withSize(18)
        label.textColor = .lightGray
        return label
    }()
    private let weatherIv = UIImageView()
    private let temperatureLabel:UILabel = {
        let label = UILabel()
        label.font=label.font.withSize(48)
        label.textColor = textColor
        return label
    }()
    private let detailWeatherTable = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private let temeratureStackView =  UIStackView()
    
    private let adapter = WeatherHourlyAdapter()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: WeatherHeaderRvItem.self.identifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupWeatherTable() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = CGSize(width: 100, height: 180)

        
        flowLayout.minimumLineSpacing = 2.0
        flowLayout.minimumInteritemSpacing = 5.0
        detailWeatherTable.collectionViewLayout = flowLayout
        detailWeatherTable.delegate = adapter
        
        
        detailWeatherTable.backgroundColor = .clear
    }
    
    private func setupConstraints() {
        temeratureStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(WeatherHeaderCell.topOffset)
            make.centerX.equalToSuperview()
        }
        conditionLabel.snp.makeConstraints { make in
            make.top.equalTo(temeratureStackView.snp.bottom)
            make.centerX.equalToSuperview()
        }
        feelsLikeLabel.snp.makeConstraints { make in
            make.top.equalTo(conditionLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }     
        detailWeatherTable.snp.makeConstraints { make in
            make.top.equalTo(feelsLikeLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-24)
        }
        weatherIv.snp.makeConstraints { make in
            make.height.width.equalTo(WeatherHeaderCell.imageSize)
        }
        detailWeatherTable.snp.makeConstraints { make in
            make.height.equalTo(180)
            make.width.equalToSuperview()
        }
        temperatureLabel.snp.makeConstraints { make in
            make.height.equalTo(WeatherHeaderCell.imageSize)
        }
    }
    
    fileprivate func setupTemeperatureStackView() {
        temeratureStackView.distribution = .equalCentering
        temeratureStackView.addArrangedSubview(temperatureLabel)
        temeratureStackView.addArrangedSubview(weatherIv)
    }
    
    private func configure(){
        contentView.addSubview(temeratureStackView)
        contentView.addSubview(conditionLabel)
        contentView.addSubview(feelsLikeLabel)
        contentView.addSubview(detailWeatherTable)
        
        setupTemeperatureStackView()
        setupConstraints()
        setupWeatherTable()
        
        detailWeatherTable.register(WeatherHourlyCell.self, forCellWithReuseIdentifier: WeatherHourlyRvItem.identifier)
        detailWeatherTable.register(WeatherDetailCell.self, forCellWithReuseIdentifier: WeatherDetailRvItem.identifier)
        detailWeatherTable.dataSource = adapter
    }
    
    func bind(item:WeatherHeaderRvItem){
        conditionLabel.text = item.condition
        feelsLikeLabel.text = item.tempFeels
        temperatureLabel.text = item.temp
        weatherIv.image = UIImage(named: item.icon)
        myLayer = contentView.addGradientBackground(firstColor: .green, secondColor: .blue)
        
        adapter.setItems(items: item.weatherDetailItems)
      }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        myLayer?.frame = contentView.bounds
    }


}
private extension UIView{
    func addGradientBackground(firstColor: UIColor, secondColor: UIColor)->CAGradientLayer{
        clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        self.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
    
}


