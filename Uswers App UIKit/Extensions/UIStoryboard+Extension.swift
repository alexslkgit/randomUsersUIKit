//
//  UIStoryboard+Extension.swift
//  Random Users UIKit
//

import UIKit

extension UIStoryboard {
    
    func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T? {
        let identifier = String(describing: type)
        return instantiateViewController(withIdentifier: identifier) as? T
    }
}
