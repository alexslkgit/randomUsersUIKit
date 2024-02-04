//
//  SceneDelegate.swift
//  Uswers App UIKit
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coreDataManager: CoreDataManager?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let windowScene = scene as? UIWindowScene else { return }

        let toUIConverter = UserEntityToUIConverter()
        let networkManager = NetworkManagerUrlSession()
        let coreDataManager = appDelegate.coreDataManager!
        let viewModel = UsersListViewModel(coreDataManager: coreDataManager,
                                           networkManager: networkManager,
                                           toUIConverter: toUIConverter)

        let usersListViewController = UsersListViewController()
        usersListViewController.viewModel = viewModel

        let usersNavigationController = UINavigationController(rootViewController: usersListViewController)
        usersNavigationController.tabBarItem = UITabBarItem(title: Constants.Localizations.firstTabTitle,
                                                            image: UIImage(named: Constants.Images.userLogo),
                                                            selectedImage: nil)

        let settingsViewController = SettingsViewController()
        settingsViewController.tabBarItem = UITabBarItem(title: Constants.Localizations.secondTabTitle,
                                                         image: UIImage(named: Constants.Images.settingsLogo),
                                                         selectedImage: nil)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [usersNavigationController, settingsViewController]

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        appDelegate.saveContext()
    }
}

