//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Dmitriy Petrov on 08.06.2020.
//  Copyright © 2020 Dmitriy Petrov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class MainViewController: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var searchBarView: SearchBar!
    
    @IBOutlet weak var temperatureSwitch: TemperatureSwitch!
    @IBOutlet weak var changeCityButton: UIButton!
    @IBOutlet weak var currentLocationView: UIView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var rainPossibilyLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    var viewModel: MainViewModel!
    var disposeBag = DisposeBag()
    
    static func initFromNib(viewModel: MainViewModel) -> MainViewController {
        let vc = MainViewController.initFromNib()
        vc.viewModel = viewModel
        
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - Bindings

private extension MainViewController {
    func bindViewModel() {
        // MARK: - Inputs binding
        
        changeCityButton.rx.tap.asDriver()
            .drive(onNext: (viewModel.manageTopViews))
            .disposed(by: disposeBag)
        
        searchBarView.searchTextField.rx.controlEvent(.editingDidEnd).asDriver()
            .drive(onNext: (viewModel.manageTopViews))
            .disposed(by: disposeBag)
        
        searchBarView.searchTextField.rx.text.orEmpty.asDriver()
            .drive(viewModel.newCityName)
            .disposed(by: disposeBag)
        
        searchBarView.okButton.rx.tap.asDriver()
            .drive(onNext: (viewModel.didTapOkSearchButton))
            .disposed(by: disposeBag)
        
        temperatureSwitch.rx.tapGesture()
            .when(.recognized)
            .map { _ in }
            .asDriver(onErrorJustReturn: ())
            .throttle(.milliseconds(300), latest: false)
            .drive(temperatureSwitch.rx.switchTapped)
            .disposed(by: disposeBag)
        
        temperatureSwitch.selectedUnitsRelay.asDriver(onErrorJustReturn: .metric)
            .drive(onNext: (viewModel.didChangeUnits))
            .disposed(by: disposeBag)
        
        // MARK: - Outputs binding
        
        viewModel.cityName.asDriver()
            .drive(cityLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.wind.asDriver()
            .drive(windLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.humidity.asDriver()
            .drive(humidityLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.pressure.asDriver()
            .drive(pressureLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.rainPossibility.asDriver()
            .drive(rainPossibilyLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.weatherDescription.asDriver()
            .drive(descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.temperature.asDriver()
            .drive(temperatureLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.weatherIcon.asDriver()
            .drive(weatherImage.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.shouldHideTopView.asDriver()
            .drive(topView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.shouldHideSearchView.asDriver()
            .drive(searchBarView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.shouldEnableOkButton.asDriver()
            .drive(searchBarView.okButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}
