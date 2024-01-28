//
//  UITableView+Extension.swift
//  Uswers App UIKit
//
//  Created by Slobodianiuk Oleksandr on 23.01.2024.
//

import UIKit

extension UITableView {
    
    private func reuseIndentifier<T>(for type: T.Type) -> String {
        return String(describing: type)
    }

    public func register<T: UITableViewCell>(cell: T.Type) {
        let nibName = String(describing: cell)
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: nibName)
    }

    public func dequeueReusableCell<T: UITableViewCell>(for type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: reuseIndentifier(for: type), for: indexPath) as? T else {
            fatalError("Failed to dequeue cell.")
        }

        return cell
    }
}
