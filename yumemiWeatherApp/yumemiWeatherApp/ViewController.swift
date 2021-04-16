//
//  ViewController.swift
//  yumemiWeatherApp
//
//  Created by 土田理人 on 2021/04/03.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weatherImageView = makeWeatherImageView()
        
        let blueLabel = makeLabel(labelName: "blue label", labelColor: UIColor.blue, leadingAnchor: weatherImageView.leadingAnchor)
        let redLabel = makeLabel(labelName: "red label", labelColor: UIColor.red, leadingAnchor: weatherImageView.centerXAnchor)
        let labelStack = arrangeTwoItemToHStack(Item1: blueLabel, Item2: redLabel)
        
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
        
        let buttonStack = arrangeTwoItemToHStack(Item1: closeButton, Item2: reloadButton)
        
        // arrange buttonStack
        view.addSubview(buttonStack)
        buttonStack.widthAnchor.constraint(equalTo: vStack.widthAnchor).isActive = true
        buttonStack.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 80).isActive = true
        buttonStack.leadingAnchor.constraint(equalTo: vStack.leadingAnchor).isActive = true
        
        
        
    }
    
    
    fileprivate func makeWeatherImageView() -> UIImageView{
        
        let image = UIImage(named: "sunny")
        let imageView = UIImageView(image: image)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
  
    }
    
    fileprivate func makeLabel(labelName: String, labelColor: UIColor, leadingAnchor: NSLayoutXAxisAnchor) -> UILabel {
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

