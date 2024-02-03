//
//  DataManagerTests.swift
//  Random Users UIKitTests
//

import XCTest
import CoreData
@testable import Random_Users_UIKit

class CoreDataManagerTests: XCTestCase {
    
    var coreDataManager: CoreDataManager!
    var mockCoreDataStack: CoreDataStack!
    var mockManagedObjectContext: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        
        mockCoreDataStack = CoreDataStack(modelName: "Users_App_UIKit")
        mockManagedObjectContext = mockCoreDataStack.newBackgroundContext()
        coreDataManager = CoreDataManager(coreDataStack: mockCoreDataStack)
    }
    
    override func tearDown() {
        mockManagedObjectContext = nil
        mockCoreDataStack = nil
        coreDataManager = nil
        
        super.tearDown()
    }
    
    func testSaveUsers_WithValidUsersArray_ShouldSaveUsers() {
        
        // Given
        let users = [User(gender: "male", name: Name(title: "Mr", first: "John", last: "Doe"), location: Location(street: Street(number: 123, name: "Test Street"), city: "Test City", state: "Test State", country: "Test Country"), email: "test@example.com", phone: "1234567890", cell: "0987654321", id: UserID(name: "SSN", value: "123-45-6789"), picture: Picture(large: "large.jpg", medium: "medium.jpg", thumbnail: "thumbnail.jpg"), nat: "US")]
        
        let saveExpectation = expectation(description: "Save completion handler invoked")
        
        // When
        coreDataManager.saveUsers(users) { error in
            // Then
            XCTAssertNil(error, "saveUsers should not return an error")
            saveExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testSaveUsers_WithEmptyUsersArray_ShouldNotCrashOrReturnError() {
        
        // Given
        let users: [User] = []
        
        let saveExpectation = expectation(description: "Save completion handler invoked")
        
        // When
        coreDataManager.saveUsers(users) { error in
            // Then
            XCTAssertNil(error, "saveUsers should not return an error for an empty array")
            saveExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
