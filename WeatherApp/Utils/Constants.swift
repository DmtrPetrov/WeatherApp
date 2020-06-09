//
//  Constants.swift
//  WeatherApp
//
//  Created by Dmitriy Petrov on 09.06.2020.
//  Copyright © 2020 Dmitriy Petrov. All rights reserved.
//

class Constants {
    // MARK: - Networking
    static let apiKey = "753eb63a5e5beaffeb91e8e2e8f4facd"
    
    static let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
    static let query = "?q=%@&appid=%@&lang=ru&units=%@"
    
    // MARK: - Labels
    static let pressure = "мм рт. ст."
    static let windSpeed = "м/с"
    static let windNorth = "северный"
    static let windSouth = "южный"
    static let windEast = "восточный"
    static let windWest = "западный"
}
