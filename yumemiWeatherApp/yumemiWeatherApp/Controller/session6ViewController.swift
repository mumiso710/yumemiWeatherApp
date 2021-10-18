//
//  session6ViewController.swift
//  yumemiWeatherApp
//
//  Created by on 2021/04/07.
//

import UIKit

class session6ViewController: UIViewController, ViewControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let nextVC = ViewController()
        nextVC.delegate = self
        nextVC.inject(weatherModel: WeatherModelImpl())
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true)
    }
    
    func didPressedCloseButton() {
        dismiss(animated: true)
    }


    
}
