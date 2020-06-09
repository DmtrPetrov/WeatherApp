//
//  WeatherType.swift
//  WeatherApp
//
//  Created by Dmitriy Petrov on 09.06.2020.
//  Copyright © 2020 Dmitriy Petrov. All rights reserved.
//

struct WeatherType: Decodable {
    var type: WeatherTypeName
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case type = "main"
        case description
    }
}

enum WeatherTypeName: String, Decodable {
    case thunderstorm = "Thunderstorm"
    case drizzle = "Drizzle"
    case rain = "Rain"
    case snow = "Snow"
    case mist = "Mist"
    case smoke = "Smoke"
    case haze = "Haze"
    case dust = "Dust"
    case fog = "Fog"
    case sand = "Sand"
    case ash = "Ash"
    case squall = "Squall"
    case tornado = "Tornado"
    case clear = "Clear"
    case clouds = "Clouds"
}
