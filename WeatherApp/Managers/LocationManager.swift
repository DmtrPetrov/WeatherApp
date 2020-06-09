//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Dmitriy Petrov on 09.06.2020.
//  Copyright © 2020 Dmitriy Petrov. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

class LocationManager {
    var manager = CLLocationManager()
    
    init() {
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
    }
}

extension LocationManager {
    public var exposedLocation: CLLocation? {
        return manager.location
    }
    
    func getLocation(for location: CLLocation) -> Single<String?> {
        let geocoder = CLGeocoder()
        
        return .create { single in
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                guard error == nil else {
                    single(.error(error ?? LocationManagerError.unknown))
                    return
                }
                
                guard let placemark = placemarks?[0] else {
                    single(.error(LocationManagerError.noPlacemark))
                    return
                }
                
                single(.success(placemark.locality))
            }
            return Disposables.create()
        }
        
    }
}

fileprivate extension LocationManager {
    enum LocationManagerError: LocalizedError {
        case unknown
        case noPlacemark
        
        var errorDescription: String? {
            switch self {
            case .unknown:
                return "Unknown error"
            case .noPlacemark:
                return "No placemark"
            }
        }
    }
}
