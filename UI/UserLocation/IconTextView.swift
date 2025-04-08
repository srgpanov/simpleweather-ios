//
//  IconTextView.swift
//  simpleweather
//
//  Created by Панов Сергей on 08.04.2025.
//

import Foundation
import UIKit


class IconTextView : UIView {
    private let tv = UILabel()
    private let iv = UIImageView()
    
    private let iconSize = 24
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setIcon(iconId:String){
        iv.image =  UIImage(named: iconId)
    }
    
    func setText(text:String){
        tv.text = text
    }
    
    
    private func setupViews() {
        addSubview(tv)
        addSubview(iv)
        
        let textFont = UIFont.systemFont(ofSize: 16)
        tv.font = textFont
        
        tv.backgroundColor = .green
    }
    

    
    private func setupConstraints(){
        iv.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(iconSize)
        }
        tv.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iv.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
        }

    }
    
}
