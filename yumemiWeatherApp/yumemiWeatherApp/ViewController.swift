//
//  ViewController.swift
//  yumemiWeatherApp
//
//  Created by 土田理人 on 2021/04/03.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weatherImageView = makeWeatherImageView()
        
        let blueLabel = makeLabel(labelName: "blue label", labelColor: UIColor.blue)
        let redLabel = makeLabel(labelName: "red label", labelColor: UIColor.red)
        let labelStack = arrangeTwoItemToHStack(Item1: blueLabel, Item2: redLabel)
        
        // vStack set up
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vStack)
        
        
        vStack.addArrangedSubview(weatherImageView)
        
        // change image size
        weatherImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        weatherImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        
        vStack.addArrangedSubview(labelStack)
      
        // arrange vStack
        vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        let closeButton = makeButton(buttonName: "Close")
        let reloadButton = makeButton(buttonName: "Reload")
        
        // when "ReloadButton" pressed, update the weather image
        reloadButton.addAction(UIAction(handler: { _ in
            let weather = YumemiWeather.fetchWeather()
            weatherImageView.image = UIImage(named: weather)
            weatherImageView.image = weatherImageView.image?.withTintColor(self.getImageColor(weather: weather), renderingMode: .alwaysOriginal)
        }), for: .touchUpInside)
        
        let buttonStack = arrangeTwoItemToHStack(Item1: closeButton, Item2: reloadButton)
        
        // arrange buttonStack
        view.addSubview(buttonStack)
        buttonStack.widthAnchor.constraint(equalTo: vStack.widthAnchor).isActive = true
        buttonStack.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 80).isActive = true
        buttonStack.leadingAnchor.constraint(equalTo: vStack.leadingAnchor).isActive = true
    
    }
    
    
    fileprivate func makeWeatherImageView() -> UIImageView{
        
        let weather = YumemiWeather.fetchWeather()
        
        var image = UIImage(named: weather)
        let imageColor = getImageColor(weather: weather)
        image = image?.withTintColor(imageColor, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
  
    }
    
    fileprivate func getImageColor(weather: String) -> UIColor {
        if weather == "sunny" {
            return UIColor.red
        } else if weather == "cloudy" {
            return UIColor.gray
        } else {
            return UIColor.blue
        }
    }
    
    
    fileprivate func makeLabel(labelName: String, labelColor: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = labelName
        label.textColor = labelColor
        label.textAlignment = .center
        
        return label
    }
    
    fileprivate func makeButton(buttonName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(buttonName, for: .normal)
        button.setTitleColor(.cyan, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    fileprivate func arrangeTwoItemToHStack(Item1: UIView, Item2: UIView) -> UIStackView {

        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(Item1)
        stack.addArrangedSubview(Item2)
        stack.distribution = .fillEqually
        
        return stack
    }
    
}

