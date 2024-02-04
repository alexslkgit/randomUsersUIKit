//
//  UIFactory.swift
//  Random Users UIKit
//

import UIKit

struct UIFactory {
    
    // MARK: - TableView
    
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
    
    // MARK: - TableView
    
    static func createScrollView(delegate: UIScrollViewDelegate) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = delegate
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }
    
    // MARK: - Navigation
    
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
    
    // MARK: - Image View
    
    static func createImageView(contentMode: UIView.ContentMode = .scaleAspectFit,
                                isTranslatesAutoresizingMaskIntoConstraints: Bool = false,
                                accessID: String? = nil) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = isTranslatesAutoresizingMaskIntoConstraints
        imageView.contentMode = contentMode
        imageView.accessibilityIdentifier = accessID
        return imageView
    }
    
    // MARK: - Gestures
    
    static func createTapGesture(target: Any?, action: Selector) -> UITapGestureRecognizer {
        return UITapGestureRecognizer(target: target, action: action)
    }
    
    static func createSwipeGesture(target: Any?, action: Selector, direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let swipeGesture = UISwipeGestureRecognizer(target: target, action: action)
        swipeGesture.direction = direction
        return swipeGesture
    }
    
    // MARK: - Elements
    
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
    
    static func createActivityIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        return indicator
    }
    
}
