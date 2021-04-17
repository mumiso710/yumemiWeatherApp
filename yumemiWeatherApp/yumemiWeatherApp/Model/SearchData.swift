//
//  searchData.swift
//  yumemiWeatherApp
//

//

import Foundation

struct SearchData: Codable {
    let area: String
    let date: String
    
    init(area: String) {
        let formatter = DateFormatter()        
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        self.area = area
        self.date = formatter.string(from: Date())
    }
    
    
    func createJSON() throws -> String? {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        return String(data: data, encoding: .utf8)
    }

}

