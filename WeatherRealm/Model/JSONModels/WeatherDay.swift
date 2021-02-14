//
//  WeatherDay.swift
//  WeatherRealm
//
//  Created by Alisiya on 09.02.2021.
//

import Foundation

struct WeatherDay: Decodable {
    var weather: WeatherDescription?
    var minTemp: Double?
    var maxTemp: Double?
    var datetime: String?
    
    enum CodingKeys: String, CodingKey {
        case weather
        case minTemp = "low_temp"
        case maxTemp = "max_temp"
        case datetime

    }
}
