//
//  FavouriteCell.swift
//  simpleweather
//
//  Created by Панов Сергей on 04.01.2025.
//

import Foundation
import UIKit


class FavouriteCell :UITableViewCell {
    
    let tvTime = UILabel()
    let tvTitle = UILabel()
    let tvTemp = UILabel()
    let ivIcon = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: SettingsSwitchRvItem.self.identifier)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(item:FavouriteRvItem){
        tvTime.text = item.time
        tvTitle.text = item.title
        tvTemp.text = item.temp
        ivIcon.image = UIImage(named: item.icon)
    }
    
    private func configure(){
        contentView.addSubview(tvTime)
        contentView.addSubview(tvTitle)
        contentView.addSubview(tvTemp)
        contentView.addSubview(ivIcon)
        
        ivIcon.backgroundColor = .gray
        tvTemp.backgroundColor = .gray
        tvTime.backgroundColor = .gray
        tvTitle.backgroundColor = .gray
        
        tvTemp.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        tvTime    .font = UIFont.systemFont(ofSize: 16)
        let titleFont = UIFont.systemFont(ofSize: 24)
        tvTitle    .font = titleFont
        tvTemp    .font = titleFont
        
        setupConstraints()
        
        
    }
    
    private func setupConstraints(){
        tvTitle.snp.makeConstraints { make in
            make.centerY.lessThanOrEqualToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.lessThanOrEqualTo(tvTemp.snp.leading).offset(-16)
        }
        tvTime.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
        }
        tvTemp.snp.makeConstraints { make in
            make.centerY.lessThanOrEqualToSuperview()
            make.trailing.equalTo(ivIcon.snp.leading ).offset(-16)
        }
        ivIcon.snp.makeConstraints { make in
            make.centerY.lessThanOrEqualToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(32)
        }
    }
}
