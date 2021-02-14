//
//  City.swift
//  WeatherRealm
//
//  Created by Alisiya on 10.02.2021.
//

import Foundation
import RealmSwift

final class City: Object {
    @objc dynamic var name = ""
    let days = List<Day>()
    
    convenience init(cityName: String) {
        self.init()
        self.name = cityName
    }
}
