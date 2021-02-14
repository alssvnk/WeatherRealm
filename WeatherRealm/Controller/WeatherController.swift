//
//  WeatherController.swift
//  WeatherRealm
//
//  Created by Alisiya on 10.02.2021.
//

import Foundation
import RealmSwift

final class WeatherController {
    
    weak var viewController: WeatherViewController?
    
    private var realmCities: Results<City>?
    private var cities = ["Minsk","London","Paris"]
    private let collectionViewCellId = "CustomCollectionViewCell"

    
    init(viewController: WeatherViewController) {
        self.viewController = viewController
    }
    
    private func loadWeatherRealm() {
        self.realmCities = realm.objects(City.self)
    }
    
    private func loadWeatherAPI() {
        for city in cities {
            NetworkManager.getJSON(city: city) { result in
                switch result {
                case .success(let data):
                    self.saveInformation(data: data)
                    self.loadWeatherRealm()
                    self.viewController?.weatherCollectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    private func saveInformation(data: WeatherResponse) {
        guard
            let cityName = data.city,
            let dayItems = data.days else { return }
                
        let city = City(cityName: cityName)
        
        for weather in dayItems {
            guard
                let dateTime = weather.datetime,
                let min = weather.minTemp,
                let max = weather.maxTemp,
                let weatherDescriptionResponse = weather.weather,
                let description = weatherDescriptionResponse.description else { return }

            let day = Day(date: dateTime, min: min, max: max, description: description)
                        
            try! realm.write { ()-> Void in
                city.days.append(day)
                realm.add(city)
            }
        }
    }
}

extension WeatherController: WeatherViewControllerDataSource {
    
    func checkDatabase() {
        if realm.objects(City.self).count == 0 {
            self.loadWeatherAPI()
        } else {
            self.loadWeatherRealm()
        }
    }
    
    func collectionViewCellCount() -> Int {
        guard let cities = realmCities else {
            return 0
        }
        return cities.count
    }
    
    func getCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell? {
        guard let cities = realmCities else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellId, for: indexPath) as? CustomCollectionViewCell
        let city = cities[indexPath.row]
        let cellController = CollectionCellController(with: city)
        cell?.dataSource = cellController
        cell?.setupCollectionCell()
        return cell
    }
}
