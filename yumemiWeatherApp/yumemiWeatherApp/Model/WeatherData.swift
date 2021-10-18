//
//  WeatherData.swift
//  yumemiWeatherApp
//
//  Created by 土田理人 on 2021/04/04.
//

import Foundation
import UIKit

struct WeatherData: Codable {
   // let weather: String
    let weather: Weather
    let max_temp: Int
    let min_temp: Int
    let date: String
    
    
    func getImageColor() -> UIColor {
        switch self.weather {
        case .sunny:
            return UIColor.red
        case .cloudy:
            return UIColor.gray
        case .rainy:
            return UIColor.blue
        }
    }
    
}

enum Weather: String, Codable {
    case sunny
    case cloudy
    case rainy
}
