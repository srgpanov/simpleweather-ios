//
//  WeatherPager.swift
//  simpleweather
//
//  Created by Панов Сергей on 08.01.2025.
//

import Foundation
import UIKit

class WeatherPager : UIPageViewController{
    private var weatherItems: [SearchEntityDto]
    private var currentIndex: Int
    
    
    init(){
        weatherItems=FavouriteStorage().getFavouriteElements()
        currentIndex=0
        super.init(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        
        if let weatherDetails:WeatherDetailsViewController = weatherViewControllerAtIndex(index: currentIndex) {
            setupToolbar(dto:weatherDetails.location)
            
            let viewControllers = [weatherDetails]
            setViewControllers(
                viewControllers,
                direction: .forward,
                animated: false,
                completion: nil
            )
        }
    }
    
    
    private func weatherViewControllerAtIndex( index: Int) -> WeatherDetailsViewController? {
        
        guard (0...weatherItems.count).contains(index) else { return nil }
        
        let item = weatherItems[index]
        
        return WeatherDetailsViewController(geolocation: item, isPreview: false)
    }
    
    private func setupToolbar(dto:SearchEntityDto){
        navigationItem.title = dto.name
    }
}


extension WeatherPager:UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard currentIndex > 0 else { return nil }
        return weatherViewControllerAtIndex(index:currentIndex - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard currentIndex < weatherItems.count - 1 else { return nil }
        return weatherViewControllerAtIndex(index:currentIndex + 1)
    }
    
}

extension WeatherPager:UIPageViewControllerDelegate{
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        
        let s = (previousViewControllers as! [WeatherDetailsViewController]).map { WeatherDetailsViewController in
            WeatherDetailsViewController.location.name
        }
        let d = weatherItems.map { item in
            item.name
        }
        print("previousViewControllers=\(previousViewControllers) transitionCompleted=\(completed) finished=\(finished) s=\(s) weatherItems=\(d)")
        
        guard
            let controllers:[WeatherDetailsViewController] = pageViewController.viewControllers as? [WeatherDetailsViewController],
            let currentController = controllers.first,
            let index = weatherItems.firstIndex(of: currentController.location)
        else {
            return
        }
        
        setupToolbar(dto:currentController.location)
        
        currentIndex = index
    }
    
    func pageViewControllerSupportedInterfaceOrientations(_ pageViewController: UIPageViewController) -> UIInterfaceOrientationMask{
        .allButUpsideDown
    }
    
    func pageViewControllerPreferredInterfaceOrientationForPresentation(_ pageViewController: UIPageViewController) -> UIInterfaceOrientation{
        .portrait
    }
    
}
