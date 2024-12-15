//
//  SettingsViewController.swift
//  simpleweather
//
//  Created by Панов Сергей on 11.02.2024.
//

import UIKit
import RxSwift

class SettingsViewController: UIViewController {
    private let backButtonImageView = UIImageView()
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    private let recycler = UITableView()
    private lazy var adapter:SettingsAdapter = {
        return SettingsAdapter(listener:{(item,bool) in
            self.viewModel.onSwitchClick(item: item,isTurnOn:  bool)
        })
    }()
    private let viewModel = SettingsViewModel()
    
    private let bag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    private func setupViews(){
        setupConstraints()
        setupToolbar()
        setupRecycler()
    }
    
    private func setupRecycler(){
        recycler.register(SettingsSwitchCell.self, forCellReuseIdentifier: SettingsSwitchRvItem.identifier)
        recycler.dataSource = adapter
        recycler.delegate = adapter
        
        
        
        recycler.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        viewModel.itemsList.subscribe (
            onNext:{ items in
                self.adapter.setItems(items: items)
                self.recycler.reloadData()
            },
            onCompleted: nil,
            onDisposed: nil
        )
        .disposed(by: bag)
        
    }
    
    private func setupConstraints(){
    }
    
    func setupToolbar(){

        
        navigationItem.title = "settings_screen_title".asStringRes()
        
        backButtonImageView.backgroundColor = .red
        titleLabel.backgroundColor = .red
        
        
        let leftImageBtn = createToolbarButton()
        leftImageBtn.setOnClickListener {
            self.onBackButtonClick()
        }
        let leftBtn = UIBarButtonItem(customView: leftImageBtn)
        navigationItem.leftBarButtonItem = leftBtn
    }
    
    @objc func onBackButtonClick() {
        navigationController!.popViewController(animated: true)
    }
    
    private func createToolbarButton()->UIButton {
        let config = UIImage.SymbolConfiguration(pointSize: 25.0, weight: .medium, scale: .medium)
        let image = UIImage(systemName: "chevron.left", withConfiguration: config)
        let backButton = UIButton(type: .custom)
        backButton.setImage(image, for: .normal)
        backButton.setTitleColor(backButton.tintColor, for: .normal)

        return backButton
    }
    
    override func loadView() {
        let rootView = UIView()
        
        rootView.addSubview(recycler)
        self.view=rootView
    }
    
}
