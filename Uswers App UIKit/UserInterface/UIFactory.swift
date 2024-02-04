//
//  UIFactory.swift
//  Random Users UIKit
//

import UIKit

struct UIFactory {
    
    static func createLabel(text: String = "",
                            alignment: NSTextAlignment = .center,
                            isTranslatesAutoresizingMaskIntoConstraints: Bool = false,
                            accessID: String? = nil) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = isTranslatesAutoresizingMaskIntoConstraints
        label.textAlignment = alignment
        label.text = text
        label.accessibilityIdentifier = accessID
        return label
    }
    
    static func createImageView(contentMode: UIView.ContentMode = .scaleAspectFit, 
                                isTranslatesAutoresizingMaskIntoConstraints: Bool = false,
                                accessID: String? = nil) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = isTranslatesAutoresizingMaskIntoConstraints
        imageView.contentMode = contentMode
        imageView.accessibilityIdentifier = accessID
        return imageView
    }
    
    static func createTableView(rowHeight: CGFloat, 
                                dataSource: UITableViewDataSource,
                                delegate: UITableViewDelegate,
                                isTranslatesAutoresizingMaskIntoConstraints: Bool = false,
                                cellType: UITableViewCell.Type,
                                accessID: String? = nil) -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = isTranslatesAutoresizingMaskIntoConstraints
        tableView.register(cell: cellType)
        tableView.rowHeight = rowHeight
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.accessibilityIdentifier = accessID
        return tableView
    }
    
    static func createRefreshControl(target: Any?, action: Selector) -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(target, action: action, for: .valueChanged)
        return refreshControl
    }
    
    static func createTabBarController(viewControllers: [UIViewController], 
                                       accessID: String? = nil) -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = viewControllers
        tabBarController.tabBar.accessibilityIdentifier = accessID
        return tabBarController
    }
    
    static func createNavigationController(rootViewController: UIViewController,
                                           tabTitle: String,
                                           image: UIImage?,
                                           selectedImage: UIImage?,
                                           accessID: String? = nil) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem = UITabBarItem(title: tabTitle, image: image, selectedImage: selectedImage)
        navigationController.tabBarItem.accessibilityIdentifier = accessID
        return navigationController
    }
    
    static func createBackItem(title: String = "", accessID: String? = nil) -> UIBarButtonItem {
        let backItem = UIBarButtonItem()
        backItem.title = title
        backItem.accessibilityIdentifier = accessID
        return backItem
    }
    
   
}
