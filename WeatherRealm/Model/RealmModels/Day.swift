//
//  Day.swift
//  WeatherRealm
//
//  Created by Alisiya on 11.02.2021.
//

import Foundation
import RealmSwift

final class Day: Object {
    @objc dynamic var date = ""
    @objc dynamic var minTemp = 0.0
    @objc dynamic var maxTemp = 0.0
    @objc dynamic var weather = ""
    
    convenience init(date: String, min: Double, max: Double, description: String) {
        self.init()
        self.date = date
        self.minTemp = min
        self.maxTemp = max
        self.weather = description
    }
}
