//
//  ViewModel.swift
//  Random Users UIKit
//
//  Created by Slobodianiuk Oleksandr on 04.02.2024.
//

import Foundation

@propertyWrapper
struct ViewModel<ViewModelType> {
    
    private var value: ViewModelType?
    
    var wrappedValue: ViewModelType {
        get {
            guard let value = value else {
                fatalError("viewModel must be set before accessing the ViewController")
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
