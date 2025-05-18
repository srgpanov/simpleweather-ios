//
//  SwitchCell.swift
//  simpleweather
//
//  Created by Панов Сергей on 10.03.2024.
//

import UIKit

class SettingsSwitchCell :UITableViewCell {

    let label = UILabel()
    let switchView = UISwitch()
        
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: SettingsSwitchRvItem.self.identifier)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(item:SettingsSwitchRvItem){
        label.text = item.text
        switchView.isOn=item.isTurnOn
    }
    
    private func configure(){
        contentView.addSubview(label)
        contentView.addSubview(switchView)
        
        setupConstraints()
        

    }
    
    private func     setupConstraints(){
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        switchView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
