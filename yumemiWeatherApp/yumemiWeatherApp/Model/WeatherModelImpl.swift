//
//  WeatherModelImpl.swift
//  yumemiWeatherApp
//

import Foundation
import YumemiWeather


protocol WeatherModel {
    var delegate: WeatherModelDelegate? { get set }
    func getWeatherData(area: String) -> Result<WeatherData, YumemiWeatherError>
}

protocol WeatherModelDelegate {
    func didGetWeatherData()
}


class WeatherModelImpl: WeatherModel  {
    var delegate: WeatherModelDelegate?

    func getWeatherData(area: String) -> Result<WeatherData, YumemiWeatherError> {
        do {
            let searchData = try SearchData(area: area).createJSON()!
            let jsonWeather = try YumemiWeather.syncFetchWeather(searchData)
            let weatherData = parseJSON(stringData: jsonWeather)!
            
            delegate?.didGetWeatherData()
            return .success(weatherData)
        } catch {
            return .failure(error as! YumemiWeatherError)
        }
    }
}



fileprivate func parseJSON(stringData: String) -> WeatherData? {
    let decoder = JSONDecoder()
    do {
        let decodedData = try decoder.decode(WeatherData.self, from: stringData.data(using: .utf8)!)
        return decodedData
    } catch {
        print(error)
        return nil
    }
}
