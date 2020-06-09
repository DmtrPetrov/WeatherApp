//
//  UIImage+Extensions.swift
//  WeatherApp
//
//  Created by Dmitriy Petrov on 09.06.2020.
//  Copyright © 2020 Dmitriy Petrov. All rights reserved.
//

import UIKit

extension UIImage {
    static var cloudy: UIImage? {
        return UIImage(named: "cloud")
    }
    
    static var partlyCloudy: UIImage? {
        return UIImage(named: "partlyCloudy")
    }
    
    static var rainy: UIImage? {
        return UIImage(named: "rain")
    }
    
    static var storm: UIImage? {
        return UIImage(named: "storm")
    }
    
    static var sunny: UIImage? {
        return UIImage(named: "sunny")
    }
}
