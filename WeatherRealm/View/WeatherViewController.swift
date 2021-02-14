//
//  ViewController.swift
//  WeatherRealm
//
//  Created by Alisiya on 08.02.2021.
//

import UIKit

protocol WeatherViewControllerDataSource {
    func checkDatabase()
    func collectionViewCellCount() -> Int
    func getCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell?
}

final class WeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    
    private var dataSource: WeatherViewControllerDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        try! realm.write({ () -> Void in
//            realm.deleteAll()
//        })
        let controller = WeatherController(viewController: self)
        self.dataSource = controller
        dataSource.checkDatabase()
        self.weatherCollectionView.reloadData()
    }
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.collectionViewCellCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dataSource?.getCell(for: collectionView, at: indexPath) else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cvRect = collectionView.frame
        return CGSize(width: cvRect.width, height: cvRect.height)        
    }
}
