//
//  WeatherModelImpl.swift
//  yumemiWeatherApp
//

import Foundation
import YumemiWeather


protocol WeatherModel {
    var delegate: WeatherModelDelegate? { get set }
    func getWeatherData(area: String)
}

protocol WeatherModelDelegate {
    func didGetWeatherData(result: Result<WeatherData, YumemiWeatherError>)
}

typealias weatherResult = Result<WeatherData, YumemiWeatherError>
class WeatherModelImpl: WeatherModel  {
    
    var delegate: WeatherModelDelegate?

    func getWeatherData(area: String) {
        do {
            let searchData = try SearchData(area: area).createJSON()!
            let jsonWeather = try YumemiWeather.syncFetchWeather(searchData)
            let weatherData = parseJSON(stringData: jsonWeather)!
            
            delegate?.didGetWeatherData(result: .success(weatherData))
        } catch {
            delegate?.didGetWeatherData(result: .failure(error as! YumemiWeatherError))
        }
    }
    
    //TODO: session11
    func getWeatherDataCallBack(area: String, completion: (weatherResult) -> Void) {
        do {
            let searchData = try SearchData(area: area).createJSON()!
            let jsonWeather = try YumemiWeather.syncFetchWeather(searchData)
            let weatherData = parseJSON(stringData: jsonWeather)!
            
            delegate?.didGetWeatherData(result: .success(weatherData))
        } catch {
            delegate?.didGetWeatherData(result: .failure(error as! YumemiWeatherError))
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
