//
//  WeatherResponse.swift
//  WeatherRealm
//
//  Created by Alisiya on 09.02.2021.
//

import Foundation

struct WeatherResponse: Decodable {
    var days: [WeatherDay]?
    var city: String?
    
    enum CodingKeys: String, CodingKey {
        case days = "data"
        case city = "city_name"
    }
}
