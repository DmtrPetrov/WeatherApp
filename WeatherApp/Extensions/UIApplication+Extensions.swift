//
//  UIApplication+Extensions.swift
//  WeatherApp
//
//  Created by Dmitriy Petrov on 09.06.2020.
//  Copyright © 2020 Dmitriy Petrov. All rights reserved.
//

import UIKit

extension UIApplication {
    static var rootViewController: UIViewController? {
        get { shared.keyWindow?.rootViewController }
        set { shared.keyWindow?.rootViewController = newValue }
    }
}
