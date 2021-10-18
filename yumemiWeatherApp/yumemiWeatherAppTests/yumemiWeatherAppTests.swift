//
//  yumemiWeatherAppTests.swift
//  yumemiWeatherAppTests
//


import XCTest
@testable import yumemiWeatherApp
import YumemiWeather

class yumemiWeatherAppTests: XCTestCase {
    
    
    
    override func setUpWithError() throws {
        //        let weatherModel = WeatherModelTestImpl()
        //        let viewController = ViewController()
        //        viewController.inject(weatherModel: weatherModel)
        //        viewController.viewDidLoad()
        //        print(viewController.getWeather())
    }
    
    func testViewController() {
        let sunnyModel = WeatherModelSunnyImpl()
        let cloudyModel = WeatherModelCloudyImpl()
        let rainyModel = WeatherModelRainyImpl()
        
        let viewSunnyController = ViewController.create(weatherModel: sunnyModel)
        let viewCloudyController = ViewController.create(weatherModel: cloudyModel)
        let viewRainyController = ViewController.create(weatherModel: rainyModel)
        
        
        
        XCTContext.runActivity(named: "weatherImageTest") { _ in
            XCTContext.runActivity(named: "case: sunny") { _ in
                XCTAssertTrue("sunny" == viewSunnyController.getWeather())
            }
            XCTContext.runActivity(named: "case: cloudy") { _ in
                XCTAssertTrue("cloudy" == viewCloudyController.getWeather())
            }
            XCTContext.runActivity(named: "case: rainy") { _ in
                XCTAssertTrue("rainy" == viewRainyController.getWeather())
            }
        }
        
        XCTContext.runActivity(named: "UILabelTest") { _ in
            XCTContext.runActivity(named: "case: maxTempLabel") { _ in
                XCTAssertTrue("24" == viewSunnyController.maxTempLabel.text)
            }
            XCTContext.runActivity(named: "case: minTempLabel") { _ in
                XCTAssertTrue("10" == viewCloudyController.minTempLabel.text)
            }
        }
        
        
    }
    
}


//MARK: - WeatherModelTestImpl
class WeatherModelSunnyImpl: WeatherModel {
    var delegate: WeatherModelDelegate?
    func getWeatherData(area: String) {
        return .success(WeatherData(weather: .sunny, max_temp: 24, min_temp: 10, date: "2020-04-01T12:00:00+09:00"))
    }
}
class WeatherModelCloudyImpl: WeatherModel {
    var delegate: WeatherModelDelegate?
    func getWeatherData(area: String) {
        return .success(WeatherData(weather: .cloudy, max_temp: 24, min_temp: 10, date: "2020-04-01T12:00:00+09:00"))
    }
}
class WeatherModelRainyImpl: WeatherModel {
    var delegate: WeatherModelDelegate?
    func getWeatherData(area: String) {
        return .success(WeatherData(weather: .rainy, max_temp: 24, min_temp: 10, date: "2020-04-01T12:00:00+09:00"))
    }
}

