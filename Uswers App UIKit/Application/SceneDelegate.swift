//
//  SceneDelegate.swift
//  Uswers App UIKit
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coreDataManager: CoreDataManager?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let toUIConverter = UserEntityToUIConverter()
        let networkManager = NetworkManagerUrlSession()
        let coreDataManager = appDelegate.coreDataManager!
        let viewModel = UsersListViewModel(coreDataManager: coreDataManager,
                                           networkManager: networkManager,
                                           toUIConverter: toUIConverter)

      
        let usersListViewController = UsersListViewController()
        usersListViewController.viewModel = viewModel

        let usersNavigationController = UIFactory.createNavigationController(
            rootViewController: usersListViewController,
            tabTitle: Constants.Localizations.firstTabTitle,
            image: UIImage(named: Constants.Images.userLogo),
            selectedImage: nil,
            accessID: Constants.AccessID.usersTabBarItem
        )

        let settingsViewController = SettingsViewController()
        settingsViewController.tabBarItem = UITabBarItem(
            title: Constants.Localizations.secondTabTitle,
            image: UIImage(named: Constants.Images.settingsLogo),
            selectedImage: nil
        )
        settingsViewController.tabBarItem.accessibilityIdentifier = Constants.AccessID.settingsTabBarItem

        let tabBarController = UIFactory.createTabBarController(
            viewControllers: [usersNavigationController, settingsViewController],
            accessID: Constants.AccessID.tabBar
        )

        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = tabBarController
            window?.makeKeyAndVisible()
        }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        appDelegate.saveContext()
    }
}

