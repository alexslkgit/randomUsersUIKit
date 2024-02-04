//
//  Uswers_App_UIKitUITests.swift
//  Uswers App UIKitUITests
//

import XCTest

final class Uswers_App_UIKitUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testOpenUserDetailsViewController() throws {
        
        let tableView = app.tables[Constants.AccessID.mainTableView]
        let firstCell = tableView.cells.element(boundBy: 0)
        firstCell.tap()
        
        let avatarImageView = app.images[Constants.AccessID.avatarImageView]
        XCTAssertTrue(avatarImageView.exists, "AvatarImageView should be visible")
    }

    
    func testTabBar() throws {
        let tabBar = app.tabBars[Constants.AccessID.tabBar]
        tabBar.buttons[Constants.AccessID.usersTabBarItem].tap()
        tabBar.buttons[Constants.AccessID.settingsTabBarItem].tap()
    }
    
    func testScroll() throws {
        
        let tableView = app.tables[Constants.AccessID.mainTableView]
        tableView.swipeDown()
        tableView.swipeUp()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
