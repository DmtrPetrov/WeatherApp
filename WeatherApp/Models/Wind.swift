//
//  Wind.swift
//  WeatherApp
//
//  Created by Dmitriy Petrov on 09.06.2020.
//  Copyright © 2020 Dmitriy Petrov. All rights reserved.
//

import Foundation

struct Wind: Decodable {
    var speed: Double
    var degree: Int
    
    enum CodingKeys: String, CodingKey {
        case speed
        case degree = "deg"
    }
}

extension Wind {
    var direction: String {
        switch degree {
        case (0...44),
             (315...360):
            return Constants.windWest
        case (45...134):
            return Constants.windNorth
        case (135...224):
            return Constants.windEast
        case (225...314):
            return Constants.windSouth
        default:
            return ""
        }
    }
}
