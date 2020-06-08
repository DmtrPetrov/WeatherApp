//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Dmitriy Petrov on 08.06.2020.
//  Copyright © 2020 Dmitriy Petrov. All rights reserved.
//

import RxSwift
import RxCocoa

class MainViewModel {
    let isSearching = BehaviorRelay<Bool>(value: false)
    
    private var disposeBag = DisposeBag()
    
    init() {
        
    }
}
