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
        
        self.view=rootView
    }
    private func setupViews(){
        tempBlock.backgroundColor = .cyan
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
    }
}
