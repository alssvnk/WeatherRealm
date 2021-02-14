//
//  CustomTableViewCell.swift
//  WeatherRealm
//
//  Created by Alisiya on 08.02.2021.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {

    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var maxTempLabel: UILabel!
    @IBOutlet private weak var minTempLabel: UILabel!

    func setupTableCell(min: String, max: String, date: String) {
        self.maxTempLabel.text = max
        self.minTempLabel.text = min
        self.dayLabel.text = date
    }
}
