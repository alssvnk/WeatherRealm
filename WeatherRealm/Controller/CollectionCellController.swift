//
//  CollectionCellController.swift
//  WeatherRealm
//
//  Created by Alisiya on 10.02.2021.
//

import UIKit

final class CollectionCellController {
    private let city: City
    private let tableViewCellId = "CustomTableViewCell"
    
    init(with city: City) {
        self.city = city
    }
}

extension CollectionCellController: CustomCollectionViewCellDataSource {
    func getWeatherImage() -> UIImage? {
        let description = city.days[0].weather.description.lowercased()
        
        switch true {
        case description.contains("snow") :
            return (UIImage(named: "Snow"))
        case description.contains("rain") :
            return (UIImage(named: "Rain"))
        case description.contains("sun") :
            return (UIImage(named: "Sun"))
        case description.contains("light") :
            return (UIImage(named: "Light"))
        case description.contains("clouds") :
            return (UIImage(named: "Clouds"))
        default:
            return (UIImage(named: "Sun"))
        }
    }
    
    func getCityName() -> String {
        return city.name
    }
    
    func tableViewCellCount() -> Int {
        return city.days.count
    }
    
    func getCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellId, for: indexPath) as? CustomTableViewCell
        let day = city.days[indexPath.row]
        
        cell?.setupTableCell(min: "\(day.minTemp)°",
                             max: "\(day.maxTemp)°",
                             date: day.date.formattedWith(format: "yyyy-MM-dd") ?? "")
        return cell
    }
}
