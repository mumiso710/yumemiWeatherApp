//
//  yumemiWeatherAppTests.swift
//  yumemiWeatherAppTests
//
//  Created by 土田理人 on 2021/04/03.
//

import XCTest
@testable import yumemiWeatherApp

class yumemiWeatherAppTests: XCTestCase {
    
    
    
    override func setUpWithError() throws {
        //        let weatherModel = WeatherModelTestImpl()
        //        let viewController = ViewController()
        //        viewController.inject(weatherModel: weatherModel)
        //        viewController.viewDidLoad()
        //        print(viewController.getWeather())
    }
    
    func testWeatherImage() {
        let weatherModel = WeatherModelSunnyImpl()
        
        let viewController = ViewController()
        
        
        
        viewController.loadViewIfNeeded()

        viewController.inject(weatherModel: weatherModel)
//        viewController.viewDidLoad()
        
        XCTContext.runActivity(named: "case: sunny") { _ in
            XCTAssertTrue("sunny" == viewController.weatherImage.accessibilityIdentifier!)
        }
        
    }
    
    
}


//MARK: - WeatherModelTestImpl
class WeatherModelSunnyImpl: WeatherModel {
    
    func getWeatherData(searchData: String) throws -> WeatherData {
        return WeatherData(weather: .sunny, max_temp: 24, min_temp: 10, date: "2020-04-01T12:00:00+09:00")
    }
}
