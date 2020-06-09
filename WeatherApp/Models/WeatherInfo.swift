//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by Dmitriy Petrov on 09.06.2020.
//  Copyright © 2020 Dmitriy Petrov. All rights reserved.
//

import UIKit

struct WeatherInfo: Decodable {
    var weatherType: [WeatherType]
    var weather: Weather
    var wind: Wind
    var cloudiness: Cloudiness
    var city: String
    
    enum CodingKeys: String, CodingKey {
        case weatherType = "weather"
        case weather = "main"
        case wind
        case cloudiness = "clouds"
        case city = "name"
    }
}

extension WeatherInfo {
    var weatherDescription: String {
        return weatherType.first?.description ?? ""
    }
    
    var temperature: String {
        return NSNumber(value: weather.temperature.rounded()).description + "º"
    }
    
    var pressure: String {
        return NSNumber(value: weather.pressure.rounded()).description + " " + Constants.pressure
    }
    
    var windInfo: String {
        return wind.speed.description + " " + Constants.windSpeed + ", " + wind.direction
    }
    
    var humidity: String {
        return weather.humidity.description + "%"
    }
    
    var rainPossibility: String {
        return cloudiness.percent.description + "%"
    }
    
    var cityName: String {
        return city
    }
    
    var icon: UIImage? {
        let type = weatherType.first?.type ?? .clear
        
        switch type {
        case .clear:
            return UIImage.sunny
        case .clouds,
             .mist:
            return UIImage.cloudy
        case .drizzle,
             .rain:
            return UIImage.rainy
        case .thunderstorm:
            return UIImage.storm
        default:
            return UIImage.sunny
        }
    }
}
