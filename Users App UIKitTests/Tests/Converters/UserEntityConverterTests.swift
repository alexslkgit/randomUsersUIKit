//
//  UserEntityConverterTests.swift
//  Random Users UIKit
//

import XCTest
import CoreData

@testable import Random_Users_UIKit

class UserEntityConverterTests: XCTestCase {
    
    var mockManagedObjectContext: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType

        let container = NSPersistentContainer(name: "Users_App_UIKit")
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to load in memory store: \(error)")
            }
        }
        
        mockManagedObjectContext = container.viewContext
    }

    override func tearDown() {
        super.tearDown()
        
        mockManagedObjectContext = nil
    }
    
    func testConvert_WithValidInput_ShouldReturnUserEntity() {
        
        // Given
        let userID = UserID(name: "name", value: "value")
        let user = User(gender: nil, name: nil, location: nil, 
                        email: nil, phone: nil, cell: nil,
                        id: userID, picture: nil, nat: nil)
        
        let converter = UserEntityConverter()
        
        // When
        let userEntity = converter.convert(input: user, in: mockManagedObjectContext)
        
        // Then
        XCTAssertNotNil(userEntity, "UserEntity should not be nil")
        XCTAssertEqual(userEntity?.id, user.id?.value, "UserEntity id should match input user id")
    }

    
    func testConvert_WithNilInput_ShouldReturnNil() {
        
        // Given
        let converter = UserEntityConverter()
        
        // When
        let userEntity = converter.convert(input: nil, in: mockManagedObjectContext)
        
        // Then
        XCTAssertNil(userEntity, "UserEntity should be nil when input is nil")
    }
}
