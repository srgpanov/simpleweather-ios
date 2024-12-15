//
//  SearchHistoryCell.swift
//  simpleweather
//
//  Created by Панов Сергей on 27.10.2024.
//

import UIKit

class TextCell: UITableViewCell {
    private let historyLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: WeatherDayRvItem.self.identifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(){
        contentView.addSubview(historyLabel)
        
        
        setupConstraints()
        
        historyLabel.font = UIFont.systemFont(ofSize: 20)
        
        historyLabel.textAlignment = .left
    }

    func bind(item:TextRvItem){
        historyLabel.font = UIFont.systemFont(ofSize: item.fontSize)
        historyLabel.text = item.text
    }

    
    fileprivate func setupConstraints() {
        historyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }

    }
}
