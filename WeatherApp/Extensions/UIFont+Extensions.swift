//
//  UIFont+Extensions.swift
//  WeatherApp
//
//  Created by Dmitriy Petrov on 08.06.2020.
//  Copyright © 2020 Dmitriy Petrov. All rights reserved.
//

import UIKit

extension UIFont {
    static func lato(size: CGFloat = 15, bold: Bool = false) -> UIFont {
        let fontName = bold ? "Lato-Bold" : "Lato-Regular"
        return UIFont(name: fontName, size: size)!
    }
    
    static func ptSans(size: CGFloat = 15) -> UIFont {
        return UIFont(name: "PTSans-Regular", size: size)!
    }
}
