//
//  SearchBar.swift
//  WeatherApp
//
//  Created by Dmitriy Petrov on 09.06.2020.
//  Copyright © 2020 Dmitriy Petrov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchBar: UIView {
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var okButton: UIButton!
    
    private func setupUI() {
        layer.masksToBounds = false
        layer.cornerRadius = 4
        layer.shadowColor = UIColor.black.cgColor

        layer.shadowRadius = 8
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
}

// MARK: - NibInstantiatiable
extension SearchBar: NibInstantiatiable {
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
