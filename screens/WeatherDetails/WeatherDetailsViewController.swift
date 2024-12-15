//
//  ViewController.swift
//  simpleweather
//
//  Created by Панов Сергей on 29.09.2023.
//

import UIKit
import SnapKit
import RxSwift

class WeatherDetailsViewController: UIViewController {
    private let recycler = UITableView()
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    private let adapter = WeatherAdapter()
    private let location :GeoLocation
    private let viewModel:WeatherDetailsViewModel
    private let bag = DisposeBag()
    
    static let toolbarHeight = 56
    static let toolbarIconsSize = 32
    static let elementOffset = 16
    
    
    init(geolocation:GeoLocation){
        self.location = geolocation
        viewModel = WeatherDetailsViewModel(location:location)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        print("WeatherDetailsViewController viewDidLoad")
        bindViewModel()
        
        
    }
    
    func bindViewModel(){
        print("WeatherDetailsViewController getWeather")
        viewModel.getWeather()
            .subscribe { items in
                
                self.adapter.setItems(items: items)
                self.recycler.reloadData()
            }
            .disposed(by: bag)
    }
    
    
    fileprivate func setupRecycler() {
        recycler.register(WeatherHeaderCell.self, forCellReuseIdentifier: WeatherHeaderRvItem.identifier)
        recycler.register(WeatherDayCell.self, forCellReuseIdentifier: WeatherDayRvItem.identifier)
        recycler.dataSource = adapter
        recycler.delegate = adapter
        recycler.rowHeight = UITableView.automaticDimension
        recycler.contentInsetAdjustmentBehavior = .never

        
        let safeAreaBottom: CGFloat = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0.0
        recycler.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: safeAreaBottom, right: 0.0);
        
        recycler.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupViews(){
        setupConstraints()
        setupRecycler()
        setupToolbar()
        
    }
    func setupToolbar(){

        navigationItem.title = "Краснодар"
        
        let leftImageBtn = createToolbarButton()
        let leftBtn = UIBarButtonItem(customView: leftImageBtn)
//        leftBtn.image = UIImage(named: "ic_ovc")
        navigationItem.leftBarButtonItem = leftBtn
        
       let  rightImageBtn = createToolbarButton()
        let rightBtn = UIBarButtonItem(customView: rightImageBtn)
//        rightBtn.image = UIImage(named: "ic_ovc")
        navigationItem.rightBarButtonItem = rightBtn
        
        titleLabel.backgroundColor = .red
        
        
        
        
        leftImageBtn.setOnClickListener{
            let viewController = FavouritesViewController()
            self.navigationController!.pushViewController(viewController, animated: true)
        }
        rightImageBtn.setOnClickListener{
            self.onSettingsButtonClick()
        }
        navigationItem.titleView?.backgroundColor = .blue
        
        
    }
    
    private func createToolbarButton()->UIButton {
        let config = UIImage.SymbolConfiguration(pointSize: 25.0, weight: .medium, scale: .medium)
        let image = UIImage(named: "ic_ovc")
        let btn = UIButton(type: .custom)
        btn.setImage(image, for: .normal)
        btn.setTitleColor(btn.tintColor, for: .normal)

        return btn
    }
    
    @objc func onSettingsButtonClick() {

        let viewController = SettingsViewController()
        navigationController!.pushViewController(viewController, animated: true)
    }

    
    private func setupConstraints(){
        recycler.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
    override func loadView() {
        let rootView = UIView()
        rootView.backgroundColor = UIColor.systemBackground
        rootView.addSubview(recycler)
        
        self.view=rootView
    }
}
