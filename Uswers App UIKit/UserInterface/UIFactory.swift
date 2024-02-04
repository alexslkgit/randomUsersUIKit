//
//  UIFactory.swift
//  Random Users UIKit
//

import UIKit

struct UIFactory {
    
    static func createLabel(text: String = "",
                            alignment: NSTextAlignment,
                            isTranslatesAutoresizingMaskIntoConstraints: Bool = false) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = isTranslatesAutoresizingMaskIntoConstraints
        label.textAlignment = alignment
        label.text = text
        return label
    }
    
    static func createImageView(contentMode: UIView.ContentMode, isTranslatesAutoresizingMaskIntoConstraints: Bool = false) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = isTranslatesAutoresizingMaskIntoConstraints
        imageView.contentMode = contentMode
        return imageView
    }
    
    static func createTableView(rowHeight: CGFloat, 
                                dataSource: UITableViewDataSource,
                                delegate: UITableViewDelegate,
                                isTranslatesAutoresizingMaskIntoConstraints: Bool = false,
                                cellType: UITableViewCell.Type) -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = isTranslatesAutoresizingMaskIntoConstraints
        tableView.register(cell: cellType)
        tableView.rowHeight = rowHeight
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        return tableView
    }
    
    static func createRefreshControl(target: Any?, action: Selector) -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(target, action: action, for: .valueChanged)
        return refreshControl
    }
}
