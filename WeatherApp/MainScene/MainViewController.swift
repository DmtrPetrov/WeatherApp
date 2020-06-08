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
    @IBOutlet weak var searchBarView: UIView!
    
    @IBOutlet weak var temperatureSwitch: TemperatureSwitch!
    @IBOutlet weak var changeCityButton: UIButton!
    @IBOutlet weak var currentLocationView: UIView!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchOkButton: UIButton!
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        temperatureSwitch.rx.tapGesture()
            .when(.recognized)
            .map { _ in }
            .bind(to: temperatureSwitch.rx.switchTapped)
            .disposed(by: disposeBag)
        
        changeCityButton.rx.tap
            .bind { [weak self] in self?.didType("s") }
            .disposed(by: disposeBag)
    }
    
    func didType(_ text: String) {
        print(changeCityButton.titleLabel?.font)
    }
}
