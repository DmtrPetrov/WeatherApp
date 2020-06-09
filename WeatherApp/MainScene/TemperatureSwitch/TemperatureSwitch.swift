//
//  TemperatureSwitch.swift
//  WeatherApp
//
//  Created by Dmitriy Petrov on 08.06.2020.
//  Copyright © 2020 Dmitriy Petrov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TemperatureSwitch: UIView {
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var celsiusView: UIView!
    @IBOutlet weak var celsiusLabel: UILabel!
    
    @IBOutlet weak var fahrenheitView: UIView!
    @IBOutlet weak var fahrenheitLabel: UILabel!
    
    var selectedUnitsRelay = PublishRelay<Units>()
    
    var selectedUnits: Units = .metric {
        didSet {
            selectedUnitsRelay.accept(selectedUnits)
            updateUI()
        }
    }
    
    private let selectedColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
    
    private func updateUI() {
        guard selectedUnits == .metric else {
            celsiusView.backgroundColor = .clear
            fahrenheitView.backgroundColor = selectedColor
            
            celsiusLabel.font = UIFont.lato()
            fahrenheitLabel.font = UIFont.lato(bold: true)
            return
        }
        
        celsiusView.backgroundColor = selectedColor
        fahrenheitView.backgroundColor = .clear
        
        celsiusLabel.font = UIFont.lato(bold: true)
        fahrenheitLabel.font = UIFont.lato()
    }
    
    private func setupUI() {
        layer.masksToBounds = true
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2).cgColor
        updateUI()
    }
}

// MARK: - NibInstantiatiable
extension TemperatureSwitch: NibInstantiatiable {
    override func awakeFromNib() {
        super.awakeFromNib()
        nibSetup()
        setupUI()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        nibSetup()
        contentView.prepareForInterfaceBuilder()
    }
}

extension Reactive where Base: TemperatureSwitch {
    var switchTapped: Binder<Void> {
        return Binder(base) { temperatureSwitch, _ in
            let newValue: Units = temperatureSwitch.selectedUnits == .metric ? .imperial : .metric
            temperatureSwitch.selectedUnits = newValue
        }
    }
}
