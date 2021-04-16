//
//  WeatherModelImpl.swift
//  yumemiWeatherApp
//
//  Created by 土田理人 on 2021/04/08.
//

import Foundation
import YumemiWeather


protocol WeatherModel {
    func getWeatherData(searchData: String) throws -> WeatherData
}

class WeatherModelImpl: WeatherModel  {
    
    func getWeatherData(searchData: String) throws -> WeatherData {
        let jsonWeather = try YumemiWeather.fetchWeather(searchData)
        let weatherData = parseJSON(stringData: jsonWeather)!
        return weatherData
    }
}



func parseJSON(stringData: String) -> WeatherData? {
    let decoder = JSONDecoder()
    do {
        let decodedData = try decoder.decode(WeatherData.self, from: stringData.data(using: .utf8)!)
        return decodedData
    } catch {
        print(error)
        return nil
    }
}
