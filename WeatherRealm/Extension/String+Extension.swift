//
//  Extensions.swift
//  WeatherRealm
//
//  Created by Alisiya on 13.02.2021.
//

import Foundation

extension String {
    func formattedWith(format: String) -> String? {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let date = formatter.date(from: self)
        guard let d = date else { return nil }
        return String(formatter.weekdaySymbols[calendar.component(.weekday, from: d) - 1])
    }
}
