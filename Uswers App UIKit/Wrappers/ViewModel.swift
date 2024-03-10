//
//  Presenter.swift
//  Random Users UIKit
//
//  Created by Slobodianiuk Oleksandr on 04.02.2024.
//

import Foundation

@propertyWrapper
struct Presenter<PresenterType> {
    
    private var value: PresenterType?
    
    var wrappedValue: PresenterType {
        get {
            guard let value = value else {
                fatalError("presenter must be set before accessing the ViewController")
            }
            return value
        }
        set {
            value = newValue
        }
    }
    
    init() {
        self.value = nil
    }
}
