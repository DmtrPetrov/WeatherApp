//
//  UIAlertController+Extensions.swift
//  WeatherApp
//
//  Created by Dmitriy Petrov on 09.06.2020.
//  Copyright © 2020 Dmitriy Petrov. All rights reserved.
//

import RxSwift
import RxCocoa

extension UIAlertController {
    static func showError(title: String? = nil, error: Error) {
        showAlert(title: title ?? (error as? LocalizedError)?.failureReason,
                  message: (error as? LocalizedError)?.errorDescription ?? error.localizedDescription)
    }
    
    static func showMessage(title: String? = nil, message: String) {
        showAlert(title: title, message: message)
    }
    
    static func showAlert(title: String? = nil, message: String? = nil) {
        let rootViewController = UIApplication.rootViewController
        guard rootViewController?.presentedViewController as? UIAlertController == nil else { return }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        rootViewController?.present(alertController, animated: true, completion: nil)
    }
}

extension Reactive where Base: UIAlertController {
    static var error: Binder<Error> {
        return Binder(UIApplication.shared) { _, error in
            UIAlertController.showError(error: error)
        }
    }
}
