//
//  Constants.swift
//  Random Users UIKit
//

import Foundation

struct Constants {
    
    struct Images {
        static let settingsLogo = "setting"
        static let userLogo = "user"
    }

    struct Layout {
        static let rowHeight: CGFloat = 120
        static let defaultSpacing: CGFloat = 16

    }
    
    struct Localizations {
        static let firstTabTitle = "Users"
        static let secondTabTitle = "Settings"
        
        static let OK = "OK"
        static let error = "Error"
        static let settingsScreen = "Settings screen"
        static let backToList = "Users list"
    }
    
    struct AccessID {
        static let mainTableView = "mainTableView"
        static let tabBar = "tabBar"
        static let avatarImageView = "avatarImageView"
        static let usersTabBarItem = "usersTabBarItem"
        static let settingsTabBarItem = "settingsTabBarItem"
        static let nameLabel = "nameLabel"
        static let locationLabel = "locationLabel"
        static let backBarButtonItem = "backBarButtonItem"
        static let fullScreenImageView = "fullScreenImageView"
    }
    
    struct Data {
        static let coreDataModel = "Users_App_UIKit"
    }
    
    struct API {
        static let randomUserMockURL = "https://randomuser.me/api/?results=100"
    }
    
    struct ErrorMessage {
        
        static let dequeCell = "Failed to dequeue cell. Check the extension UITableView"
        static let processingImage = "Error procesing image from Data"
        static func imageLoadingError(_ error: Error) -> String {
            "Image loading error: \(error.localizedDescription)"
        }
        
    }
}

