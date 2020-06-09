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
    // MARK: - Top section relays
    let shouldHideTopView = BehaviorRelay<Bool>(value: false)
    let shouldHideSearchView = BehaviorRelay<Bool>(value: true)
    
    // MARK: - Main screen relays
    let cityName = BehaviorRelay<String>(value: "Город")
    let weatherIcon = BehaviorRelay<UIImage?>(value: nil)
    let temperature = BehaviorRelay<String>(value: "")
    let weatherDescription = BehaviorRelay<String>(value: "")
    let wind = BehaviorRelay<String>(value: "")
    let humidity = BehaviorRelay<String>(value: "")
    let rainPossibility = BehaviorRelay<String>(value: "")
    let pressure = BehaviorRelay<String>(value: "")
    
    //MARK: - Search bar relays
    let shouldEnableOkButton = BehaviorRelay<Bool>(value: false)
    let newCityName = BehaviorRelay<String>(value: "")
    let units = BehaviorRelay<Units>(value: .metric)
    
    private let weatherInfo = PublishRelay<WeatherInfo>()
    
    private var networkManager: NetworkManager
    private var locationManager: LocationManager
    private var disposeBag = DisposeBag()
    
    init(with networkManager: NetworkManager = .init(),
         and locationManager: LocationManager = .init()) {
        self.networkManager = networkManager
        self.locationManager = locationManager
        setupBindings()
        
        getWeatherInfo()
            .bind(to: weatherInfo)
            .disposed(by: disposeBag)
    }
}

// MARK: - Methods called from the view

extension MainViewModel {
    func manageTopViews() {
        shouldHideTopView.accept(!shouldHideTopView.value)
        shouldHideSearchView.accept(!shouldHideSearchView.value)
    }
    
    func didTapOkSearchButton() {
        let location = newCityName.value
        let units = self.units.value
        
        guard location != cityName.value else { return }
        
        getWeatherInfo(for: location, with: units)
            .do(onNext: { [weak self] _ in self?.resetTopViews() })
            .bind(to: weatherInfo)
            .disposed(by: disposeBag)
    }
    
    func didChangeUnits(_ units: Units) {
        let location = cityName.value
        self.units.accept(units)
        
        getWeatherInfo(for: location, with: units)
            .do(onNext: { [weak self] _ in self?.resetTopViews() })
            .bind(to: weatherInfo)
            .disposed(by: disposeBag)
    }
    
    func didTapMyLocation() {
        getCurrentLocation()
            .compactMap { $0 }
            .flatMap { [unowned self] in
                self.getWeatherInfo(for: $0, with: self.units.value)
            }
            .bind(to: weatherInfo)
            .disposed(by: disposeBag)
    }
    
    private func resetTopViews() {
        shouldHideTopView.accept(false)
        shouldHideSearchView.accept(true)
        newCityName.accept("")
    }
}

// MARK: - Binding

private extension MainViewModel {
    func setupBindings() {
        let sharedInfo = weatherInfo.share()
        sharedInfo.map { $0.humidity }.bind(to: humidity).disposed(by: disposeBag)
        sharedInfo.map { $0.rainPossibility }.bind(to: rainPossibility).disposed(by: disposeBag)
        sharedInfo.map { $0.weatherDescription }.bind(to: weatherDescription).disposed(by: disposeBag)
        sharedInfo.map { $0.icon }.bind(to: weatherIcon).disposed(by: disposeBag)
        sharedInfo.map { $0.temperature }.bind(to: temperature).disposed(by: disposeBag)
        sharedInfo.map { $0.cityName }.bind(to: cityName).disposed(by: disposeBag)
        sharedInfo.map { $0.pressure }.bind(to: pressure).disposed(by: disposeBag)
        sharedInfo
            .map { [weak self] in $0.getWindInfo(units: self?.units.value ?? .metric) }
            .bind(to: wind)
            .disposed(by: disposeBag)
        
        newCityName.map { $0.count >= 3 }.bind(to: shouldEnableOkButton).disposed(by: disposeBag)
    }
}

// MARK: - Networking

private extension MainViewModel {
    func getWeatherInfo(for location: String = "Omsk", with units: Units = .metric) -> Observable<WeatherInfo> {
        let request = networkManager.getWeatherInfo(for: location, units: units)
            .asObservable()
            .sharedMaterialize()
        
        request.errors().bind(to: UIAlertController.rx.error).disposed(by: disposeBag)
        return request.elements()
    }
    
    func getCurrentLocation() -> Observable<String?> {
        guard let location = locationManager.exposedLocation else {
            return .empty()
        }
        
        let request = locationManager.getLocation(for: location).asObservable().sharedMaterialize()
        
        request.errors().bind(to: UIAlertController.rx.error).disposed(by: disposeBag)
        return request.elements()
    }
}
