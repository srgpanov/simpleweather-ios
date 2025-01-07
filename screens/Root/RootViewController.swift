//
//  RootViewContorller.swift
//  simpleweather
//
//  Created by Панов Сергей on 30.12.2024.
//

import Foundation
import UIKit


class RootViewController: UINavigationController{
    
    var popRecognizer: InteractivePopRecognizer?
    override func viewDidLoad() {
        super.viewDidLoad()
        isNavigationBarHidden = false
        setInteractiveRecognizer()
    }
    
    private func setInteractiveRecognizer() {
        popRecognizer = InteractivePopRecognizer(controller: self)
        interactivePopGestureRecognizer?.delegate = popRecognizer
    }
}
