//
//  Cloudiness.swift
//  WeatherApp
//
//  Created by Dmitriy Petrov on 09.06.2020.
//  Copyright © 2020 Dmitriy Petrov. All rights reserved.
//

struct Cloudiness: Decodable {
    var percent: Int
    
    enum CodingKeys: String, CodingKey {
        case percent = "all"
    }
}
