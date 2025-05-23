//
//  SearchViewController.swift
//  simpleweather
//
//  Created by Панов Сергей on 06.10.2024.
//

import UIKit
import RxSwift

class FavouritesViewController: UIViewController ,UISearchResultsUpdating, UISearchBarDelegate, UIGestureRecognizerDelegate{
    
    private let recycler = UITableView()
    private let  searchController = UISearchController(searchResultsController: nil)
    
    private let viewModel = FavouritesViewModel()
    private let adapter = FavouriteAdapter()
    private let bag = DisposeBag()
    private let onLocationSelected: (WeatherPlace) ->Void
    
    init (onLocationSelected:@escaping (WeatherPlace)->Void) {
        self.onLocationSelected = onLocationSelected
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        observeViewModel()
        
    }
    private func setupViews(){
        setupToolbar()
        setupRecycler()
        setupSearch()
        //        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
    }
    private func setupSearch(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.tintColor = UIColor.black
        searchController.searchBar.delegate = self
    }
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.onSearchBarrHidden(isActive : searchController.isActive)
        if searchController.isActive {
            guard let searchText = searchController.searchBar.text else {
                return
            }
            
            viewModel.onSearchQueryChanged(query: searchText)
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.onSearchItemClick(searchItem: searchBar.text.orEmpty())
    }
    
    private func observeViewModel(){
        
        viewModel.getItemsStream().subscribe (onNext: { (items:[RvItem]) in
            self.adapter.setItems(items: items)
            self.recycler.reloadData()
        },onError: { error in
            
        })
        .disposed(by: bag)
        
        viewModel.observeSearchItemsClick()
            .subscribe(onNext: { cortege in
                if cortege.isCurrentLocationSelect {
                    self.searchController.isActive=false
                } else{
                    let viewController = WeatherDetailsViewController(geolocation: cortege.place,isPreview:true)
                    self.navigationController!.pushViewController(viewController, animated: true)
                }
            })
            .disposed(by: bag)
        
    }
    
    private func setupRecycler(){
        recycler.register(TextCell.self, forCellReuseIdentifier: TextRvItem.identifier)
        recycler.register(FavouriteCell.self, forCellReuseIdentifier: FavouriteRvItem.identifier)
        recycler.register(UserLocationCell.self, forCellReuseIdentifier: UserLocationRvItem.identifier)
        recycler.delegate = adapter
        recycler.dataSource = adapter
        recycler.separatorStyle = .none
        
        
        let safeAreaBottom: CGFloat = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0.0
        recycler.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: safeAreaBottom, right: 0.0);
        
        
        
        adapter.onFavouriteClick = { item in
            self.onLocationSelected(item.sharedArgs as! WeatherPlace)
        }
        
        adapter.onTextClick = { (index, item) in
            self.viewModel.onTextItemClick(index:index,item:item )
        }
        
        adapter.onCustomLocationClick = {
            self.searchController.isActive = true
            self.viewModel.onCustomLocationClick()
        }
        adapter.onGeoLocationClick = {
        }
        
        recycler.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
    private func setupToolbar(){
        let backItem = UINavigationItem()
        backItem.leftBarButtonItem = UIBarButtonItem()
        self.navigationItem.title = "favourite_title".asStringRes()
        let doneItem = UIBarButtonItem(title: "favourite_change".asStringRes(), style: UIBarButtonItem.Style.plain, target: nil, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem = doneItem
        self.navigationItem .searchController = searchController
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
        
        let backButton = createBackButton()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        
        
    }
    @objc func addTapped(){
        
    }
    
    private func createBackButton()->UIButton {
        let config = UIImage.SymbolConfiguration(pointSize: 25.0, weight: .medium, scale: .medium)
        let image = UIImage(systemName: "chevron.left", withConfiguration: config)
        let backButton = UIButton(type: .custom)
        backButton.setImage(image, for: .normal)
        backButton.setTitleColor(backButton.tintColor, for: .normal)
        backButton.setOnClickListener {
            self.navigationController!.popViewController(animated: true)
        }
        return backButton
    }
    
    override func loadView() {
        let rootView = UIView()
        rootView.backgroundColor = UIColor.systemBackground
        
        rootView.addSubview(recycler)
        
        self.view=rootView
    }
    
}
