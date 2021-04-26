//
//  ViewController.swift
//  yumemiWeatherApp
//


import UIKit
import YumemiWeather

class ViewController: UIViewController, WeatherModelDelegate {
    
    
    
    var minTempLabel: UILabel! = nil
    var maxTempLabel: UILabel! = nil
    var weatherImage: UIImage! = nil
    var weatherImageView: UIImageView! = nil
    let area = "tokyo"
    var weatherModel: WeatherModel! = nil
    var activityIndicator: UIActivityIndicatorView! = nil
    
    deinit {
        NSLog("deinit")
    }    
    
    func inject(weatherModel: WeatherModel) {
        self.weatherModel = weatherModel
        self.weatherModel.delegate = self
    }
    
    
    
    func getWeather() -> String? {
        return weatherImage?.accessibilityIdentifier
    }
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        // set up for NotificationCenter for observing application condition
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(updateWeather), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        // initialize activityIndicator
        activityIndicator = UIActivityIndicatorView()
        view.addSubview(activityIndicator)
        
        
        
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
            //TODO: dismissは親のViewControllerが行う(delegate design pattern を利用する)
            self.dismiss(animated: true)
        }), for: .touchUpInside)
        
        // create StackView and arrange buttons
        let buttonStack = UIStackView.create(Item1: closeButton, Item2: reloadButton)
        
        // arrange buttonStack
        view.addSubview(buttonStack)
        buttonStack.widthAnchor.constraint(equalTo: vStack.widthAnchor).isActive = true
        buttonStack.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 80).isActive = true
        buttonStack.leadingAnchor.constraint(equalTo: vStack.leadingAnchor).isActive = true
        
        // set up for ActivityIndicator
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 70).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: weatherImageView.centerXAnchor).isActive = true
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        let nextVC = ViewController()
        nextVC.inject(weatherModel: WeatherModelImpl())
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true)
    }
    
    
    
    
    
    //TODO: Resultを利用してエラーハンドリングを書き直す
    @objc fileprivate func updateWeather() {
        activityIndicator.startAnimating()
        DispatchQueue.global().async {
            
            let result = self.weatherModel.getWeatherData(area: self.area)
            var alertTitle = ""
            var alertMessage = ""

            
            switch result {
            case .success(let weatherData):
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.weatherImage = UIImage(named: weatherData.weather.rawValue)!
                    let imageColor = weatherData.getImageColor()
                    self.weatherImage = self.weatherImage.withTintColor(imageColor)
                    self.weatherImageView.image = self.weatherImage
                    self.minTempLabel.text = String(weatherData.min_temp)
                    self.maxTempLabel.text = String(weatherData.max_temp)
                }
            case .failure(YumemiWeatherError.invalidParameterError):
                alertTitle = "Invalid Parameter Error"
                alertMessage = "\(self.area) is not supported by this app."
                fallthrough
            case .failure(YumemiWeatherError.jsonDecodeError):
                alertTitle = "JSON Decode Error"
                alertMessage = "JSON decode error ouccured."
                fallthrough
            case .failure(YumemiWeatherError.unknownError):
                alertTitle = "Unknown Error"
                alertMessage = "Unknown error ouccured."
                fallthrough
            case .failure:
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.presentAlert(alertTitle: alertTitle, alertMessage: alertMessage)
                }
            }
        }
    }
    
    fileprivate func presentAlert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
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

//MARK: - ViewController
extension ViewController {
    static func create(weatherModel: WeatherModel) -> ViewController {
        let viewController = ViewController()
        viewController.inject(weatherModel: weatherModel)
        viewController.loadViewIfNeeded()
        viewController.view.layoutIfNeeded()
        return viewController
    }
    
    func didGetWeatherData() {
        print("get weather data")
    }
}

