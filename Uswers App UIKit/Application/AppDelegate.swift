//
//  AppDelegate.swift
//  Uswers App UIKit
//
//  Created by Slobodianiuk Oleksandr on 23.01.2024.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coreDataStack: CoreDataStack!
    var coreDataManager: CoreDataManager!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        coreDataStack = CoreDataStack(modelName: Constants.Data.coreDataModel)
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

}

