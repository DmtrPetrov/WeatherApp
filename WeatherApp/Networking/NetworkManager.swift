//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Dmitriy Petrov on 08.06.2020.
//  Copyright © 2020 Dmitriy Petrov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class NetworkManager {
    private var apiKey: String
    private var session: URLSession
    
    init(apiKey: String = Constants.apiKey) {
        self.apiKey = apiKey
        self.session = URLSession(configuration: .default)
    }
    
    func getWeatherInfo(for location: String, units: Units = .metric) -> Single<WeatherInfo> {
        return .create { [weak self] single in
            
            guard let url = self?.getRequestURL(with: location, and: units) else {
                single(.error(NetworkError.invalidUrl))
                return Disposables.create()
            }
            
            let request = URLRequest(url: url)
            let task = self?.session.dataTask(with: request) { (data, response, error) in
                guard let httpResponse = response as? HTTPURLResponse, let data = data else  {
                    single(.error(error ?? NetworkError.unknown))
                    return
                }
                
                do {
                    if (200...399).contains(httpResponse.statusCode) {
                        let decoder = JSONDecoder()
                        let weatherInfo = try decoder.decode(WeatherInfo.self, from: data)
                        
                        single(.success(weatherInfo))
                    } else {
                        single(.error(error ?? NetworkError.unknown))
                    }
                } catch let decodingError {
                    single(.error(decodingError))
                }
            }
            
            task?.resume()
            
            return Disposables.create {
                task?.cancel()
            }
        }
    }
    
    private func getRequestURL(with location: String, and units: Units) -> URL? {
        let query = String(format: Constants.query, location, apiKey, units.rawValue)
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let stringUrl = Constants.baseUrl + (query ?? "")
        
        return URL(string: stringUrl)!
    }
}

fileprivate extension NetworkManager {
    enum NetworkError: LocalizedError {
        case invalidUrl
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .invalidUrl:
                return "Invalid request URL"
            case .unknown:
                return "Unknown error"
            }
        }
    }

}
