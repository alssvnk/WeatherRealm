//
//  Manager.swift
//  WeatherRealm
//
//  Created by Alisiya on 09.02.2021.
//

import Foundation
import Alamofire

final class NetworkManager {

    static func getJSON(city: String, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        guard let url = url(city: city) else {
            return
        }
        let request = AF.request(url, method: .get).validate()
        request.responseData { response in
            switch response.result {
            case .success(let value):
                guard let data = try? JSONDecoder().decode(WeatherResponse.self, from: value) else {
                    completion(.failure(.unwrap))
                    return
                }
                completion(.success(data))
            case .failure(let error):
                print(error)
                completion(.failure(.network))
            }
        }
    }
    
    static func url(city: String) -> URL? {
        var component = URLComponents()
        let apiKey = "a4c84058bb884df982129c1866941056"
        component.scheme = "https"
        component.host = "api.weatherbit.io"
        component.path = "/v2.0/forecast/daily"
        component.queryItems = [URLQueryItem(name: "city", value: city),
                                URLQueryItem(name: "key", value: apiKey)]
        
        guard let url = component.url else {
            return nil
        }
        return url
    }
}

enum NetworkError: Error {
    case unwrap
    case network
}
