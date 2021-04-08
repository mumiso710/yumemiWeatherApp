//
//  ViewController.swift
//  yumemiWeatherApp
//
//  Created by 土田理人 on 2021/04/03.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {
    
    var minTempLabel: UILabel! = nil
    var maxTempLabel: UILabel! = nil
    var weatherImageView: UIImageView! = nil
    let area = "tokyo"
    let weatherModel = WeatherModelImpl()
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(updateWeather), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        
        
        minTempLabel = UILabel.create(labelName: "min temp", labelColor: UIColor.blue)
        maxTempLabel = UILabel.create(labelName: "max temp", labelColor: UIColor.red)
        let labelStack = UIStackView.create(Item1: minTempLabel, Item2: maxTempLabel)
        
        weatherImageView = UIImageView()
        updateWeather()
        
        
        
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
        
        let closeButton = UIButton.create(buttonName: "Close")
        let reloadButton = UIButton.create(buttonName: "Reload")
        
        // when "ReloadButton" pressed, update the weather image
        reloadButton.addAction(UIAction(handler: { _ in
            self.updateWeather()
        }), for: .touchUpInside)
        
        // when "CloseButton" pressed, close ViewController
        closeButton.addAction(UIAction(handler: { _ in
            self.dismiss(animated: true)
        }), for: .touchUpInside)
        
        // create StackView and arrange buttons
        let buttonStack = UIStackView.create(Item1: closeButton, Item2: reloadButton)
        
        // arrange buttonStack
        view.addSubview(buttonStack)
        buttonStack.widthAnchor.constraint(equalTo: vStack.widthAnchor).isActive = true
        buttonStack.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 80).isActive = true
        buttonStack.leadingAnchor.constraint(equalTo: vStack.leadingAnchor).isActive = true
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        let nextVC = ViewController()
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true)
    }
    
    
    
    
    fileprivate func makeJSONSearchData() -> String? {
        let searchData = SearchData(area: area)
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(searchData)
            return String(data: data, encoding: .utf8)
        } catch {
            print(error)
            return nil
        }
    }
    
    @objc fileprivate func updateWeather() {
        
        let searchData = makeJSONSearchData()!
        
        do {
            let weatherData = try weatherModel.getWeatherData(searchData: searchData)
            var image = UIImage(named: weatherData.weather)!
            let imageColor = getImageColor(weather: weatherData.weather)
            image = image.withTintColor(imageColor)
            weatherImageView.image = image
            minTempLabel.text = String(weatherData.min_temp)
            maxTempLabel.text = String(weatherData.max_temp)
            
        } catch YumemiWeatherError.invalidParameterError {
            presentAlert(alertTitle: "Invalid Parameter Error", alertMessage: "\(area) is not supported by this app.")
        } catch YumemiWeatherError.jsonDecodeError {
            presentAlert(alertTitle: "JSON Decode Error", alertMessage: "unknown error occurred.")
        } catch YumemiWeatherError.unknownError {
            presentAlert(alertTitle: "Unknown Error", alertMessage: "unknown error occurred.")
        } catch {
            print("Please press the \"Reload\" button")
        }
    }
    
    fileprivate func presentAlert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
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
    
   
}


//MARK: - UILabel
extension UILabel {
    static func create(labelName: String, labelColor: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = labelName
        label.textColor = labelColor
        label.textAlignment = .center
        
        return label
    }
}

//MARK: - UIButton
extension UIButton {
    static func create(buttonName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(buttonName, for: .normal)
        button.setTitleColor(.cyan, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
}

//MARK: - UIStackView
extension UIStackView {
    static func create(Item1: UIView, Item2: UIView) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(Item1)
        stack.addArrangedSubview(Item2)
        stack.distribution = .fillEqually
        
        return stack
    }
}

