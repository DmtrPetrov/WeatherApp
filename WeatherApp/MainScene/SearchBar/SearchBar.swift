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
        setupToolBar()
        
        layer.masksToBounds = true
        layer.cornerRadius = 4
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor

        layer.shadowRadius = 8
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    private func setupToolBar() {
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: searchTextField.frame.width, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancel))
        toolBar.setItems([cancelButton, flexible], animated: false)
        searchTextField.inputAccessoryView = toolBar
    }
    
    @objc private func cancel() {
        searchTextField.resignFirstResponder()
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
