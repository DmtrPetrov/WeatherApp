//
//  Identifiable.swift
//  WeatherApp
//
//  Created by Dmitriy Petrov on 08.06.2020.
//  Copyright © 2020 Dmitriy Petrov. All rights reserved.
//

import UIKit

protocol NibIdentifiable: class {
    static var nib: UINib { get }
}

protocol NibInstantiatiable: UIView {
    var contentView: UIView! { get set }
    var nibName: String { get }
    
    func awakeFromNib()
    func prepareForInterfaceBuilder()
}

extension NibInstantiatiable {
    var nibName: String {
        String(describing: Self.self)
    }
    
    func nibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth,
                                 .flexibleHeight]
        addSubview(view)
        contentView = view
    }

    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
                    withOwner: self,
                    options: nil).first as? UIView
    }
}

extension NibIdentifiable {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

extension NibIdentifiable where Self: UIViewController {
    static func initFromNib() -> Self {
        return Self(nibName: nibIdentifier, bundle: nil)
    }
    
    static func initFromNib(withName name: String) -> Self {
        return Self(nibName: name, bundle: nil)
    }
}

extension UIViewController: NibIdentifiable {
    static var nibIdentifier: String {
        return String(describing: self)
    }
}

