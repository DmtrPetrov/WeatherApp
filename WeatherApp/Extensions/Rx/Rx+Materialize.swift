//
//  Rx+Materialize.swift
//  WeatherApp
//
//  Created by Dmitriy Petrov on 09.06.2020.
//  Copyright © 2020 Dmitriy Petrov. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType where Element: EventConvertible {
    public func elements() -> Observable<Element.Element> {
        return compactMap { $0.event.element }
    }
    
    public func errors() -> Observable<Swift.Error> {
        return compactMap { $0.event.error }
    }
}

extension ObservableType {
    func sharedMaterialize() -> Observable<Event<Self.Element>> {
        return materialize().share()
    }
}

