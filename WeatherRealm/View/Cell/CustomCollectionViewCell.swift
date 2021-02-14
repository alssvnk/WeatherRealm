//
//  CustomCollectionViewCell.swift
//  WeatherRealm
//
//  Created by Alisiya on 08.02.2021.
//

import UIKit

protocol CustomCollectionViewCellDataSource {
    func getWeatherImage() -> UIImage?
    func getCityName() -> String
    func tableViewCellCount() -> Int
    func getCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell?
}

final class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var tempTableView: UITableView!
    
    var dataSource: CustomCollectionViewCellDataSource?
    
    func setupCollectionCell() {
        self.cityLabel.text = dataSource?.getCityName()
        self.weatherImageView.image = dataSource?.getWeatherImage()
        self.tempTableView.reloadData()
    }
}

extension CustomCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.tableViewCellCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dataSource?.getCell(for: tableView, at: indexPath) else {
            return UITableViewCell()
        }
        return cell
    }
}
