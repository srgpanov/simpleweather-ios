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
    private let adapter = WeatherAdapter()
    public let location :WeatherPlace
    private let viewModel:WeatherDetailsViewModel
    private let bag = DisposeBag()
    private let isPreview:Bool
    
    private var rightBtn:UIButton? = nil
    
    static let toolbarHeight = 56
    static let toolbarIconsSize = 32
    static let elementOffset = 16
    
    
    init(geolocation:WeatherPlace, isPreview:Bool){
        self.location = geolocation
        self.isPreview = isPreview
        viewModel = WeatherDetailsViewModel(location:geolocation, isPreview: isPreview)
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
        
        viewModel.getToolbarRightIcon()
            .subscribe(onNext: { (image:UIImage) in
                let rightBtn = self.getOrCreateToolbarRightButton()
                rightBtn.setImage(image, for: .normal)
                
            })
            .disposed(by: bag)
    }
    
    
    fileprivate func setupRecycler() {
        recycler.register(WeatherHeaderCell.self, forCellReuseIdentifier: WeatherHeaderRvItem.identifier)
        recycler.register(WeatherDayCell.self, forCellReuseIdentifier: WeatherDayRvItem.identifier)
        recycler.dataSource = adapter
        recycler.delegate = adapter
        recycler.rowHeight = UITableView.automaticDimension
        recycler.contentInsetAdjustmentBehavior = .never
        recycler.delaysContentTouches = false
        print("recycler=\(recycler.isUserInteractionEnabled) view=\(view.isUserInteractionEnabled)")

        
        let safeAreaBottom: CGFloat = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0.0
        recycler.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: safeAreaBottom, right: 0.0);
        
        adapter.forecastClickListener = {
            let viewController = ForecastViewController()
            self.navigationController!.pushViewController(viewController, animated: true)
        }
    }
    
    private func setupViews(){
        setupConstraints()
        setupRecycler()
        setupToolbar()
        
    }
    func setupToolbar(){
        guard isPreview else {
            return
        }
        
        navigationItem.title = location.name
        
        let leftImageBtn = createToolbarLeftButton()
        let leftBtn = UIBarButtonItem(customView: leftImageBtn)
        navigationItem.leftBarButtonItem = leftBtn
        
       let  rightImageBtn = getOrCreateToolbarRightButton()
        let rightBtn = UIBarButtonItem(customView: rightImageBtn)
        navigationItem.rightBarButtonItem = rightBtn
        
        
        leftImageBtn.setOnClickListener{
                self.navigationController!.popViewController(animated: true)

        }
        rightImageBtn.setOnClickListener{
                self.viewModel.onFavoriteIconClick()
        }
        navigationItem.titleView?.backgroundColor = .blue
    }
    
    private func getOrCreateToolbarRightButton()->UIButton {
        if rightBtn != nil {
            return rightBtn!
        }
        
        let btn = UIButton(type: .custom)

        btn.setTitleColor(btn.tintColor, for: .normal)
        btn.bounds = CGRect(x: 0, y: 0, width: 44, height: 44)
        rightBtn = btn
        return btn
    }
    
    fileprivate func createLeftBackButton() -> UIButton {
        let image = UIImage(systemName:  "chevron.backward")
        let btn = UIButton(type: .system)
        btn.setImage(image, for: .normal)
        
        return btn
    }
    
    private func createToolbarLeftButton()->UIButton {
        if isPreview {
            return createLeftBackButton()
        } else {
            return createLeftMenuButton()
        }
    }
    private func createLeftMenuButton()->UIButton{
        let image = UIImage(named: "ic_ovc")
        let btn = UIButton(type: .custom)
        
        btn.setImage(image, for: .normal)

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
