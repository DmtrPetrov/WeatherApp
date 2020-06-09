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
    let shouldHideTopView = BehaviorRelay<Bool>(value: false)
    let shouldHideSearchView = BehaviorRelay<Bool>(value: true)
    
    let cityName = BehaviorRelay<String>(value: "Город")
    let weatherIcon = BehaviorRelay<UIImage?>(value: nil)
    let temperature = BehaviorRelay<String>(value: "")
    let weatherDescription = BehaviorRelay<String>(value: "")
    let wind = BehaviorRelay<String>(value: "")
    let humidity = BehaviorRelay<String>(value: "")
    let rainPossibility = BehaviorRelay<String>(value: "")
    let pressure = BehaviorRelay<String>(value: "")
    
    private let weatherInfo = PublishRelay<WeatherInfo>()
    
    private var networkManager: NetworkManager
    private var disposeBag = DisposeBag()
    
    init(with networkManager: NetworkManager = .init()) {
        self.networkManager = networkManager
        setupBindings()
        getWeatherInfo()
    }
}

// MARK: - Methods called from the view

extension MainViewModel {
    func didTapChangeCity() {
        shouldHideTopView.accept(!shouldHideTopView.value)
        shouldHideSearchView.accept(!shouldHideSearchView.value)
    }
}

// MARK: - Binding

private extension MainViewModel {
    func setupBindings() {
        let sharedInfo = weatherInfo.share()
        sharedInfo.map { $0.humidity }.bind(to: humidity).disposed(by: disposeBag)
        sharedInfo.map { $0.rainPossibility }.bind(to: rainPossibility).disposed(by: disposeBag)
        sharedInfo.map { $0.windInfo }.bind(to: wind).disposed(by: disposeBag)
        sharedInfo.map { $0.weatherDescription }.bind(to: weatherDescription).disposed(by: disposeBag)
        sharedInfo.map { $0.icon }.bind(to: weatherIcon).disposed(by: disposeBag)
        sharedInfo.map { $0.temperature }.bind(to: temperature).disposed(by: disposeBag)
        sharedInfo.map { $0.cityName }.bind(to: cityName).disposed(by: disposeBag)
        sharedInfo.map { $0.pressure }.bind(to: pressure).disposed(by: disposeBag)
    }
}

// MARK: - Networking

private extension MainViewModel {
    func getWeatherInfo(for location: String = "Нью-Йорк", with units: Units = .metric) {
        let request = networkManager.getWeatherInfo(for: location, units: units)
            .asObservable()
            .sharedMaterialize()
        
        request.errors().bind(to: UIAlertController.rx.error).disposed(by: disposeBag)
        request.elements().bind(to: weatherInfo).disposed(by: disposeBag)
    }
}
