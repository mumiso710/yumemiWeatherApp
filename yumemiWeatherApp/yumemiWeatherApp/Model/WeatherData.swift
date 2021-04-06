//
//  WeatherData.swift
//  yumemiWeatherApp
//
//  Created by 土田理人 on 2021/04/04.
//

import Foundation

struct WeatherData: Codable {
    let weather: String
    let max_temp: Int
    let min_temp: Int
    let date: String
}
