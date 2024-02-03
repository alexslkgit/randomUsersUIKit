//
//  LocationEntityConverterTests.swift
//  Random Users UIKitTests
//

import XCTest
import CoreData

@testable import Random_Users_UIKit

class LocationEntityConverterTests: XCTestCase {
    
    var mockManagedObjectContext: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        
        mockManagedObjectContext = setUpInMemoryManagedObjectContext()
    }

    override func tearDown() {
        super.tearDown()
        mockManagedObjectContext = nil
    }
    
    private func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext {
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType

        let container = NSPersistentContainer(name: "Users_App_UIKit")
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to load in memory store: \(error)")
            }
        }
        return container.viewContext
    }
    
    func testConvert_WithValidInput_ShouldReturnLocationEntity() {
       
        // Given
        let location = Location(street: nil, city: "Kyiv", state: "Kyiv", country: "Ukraine")
        let converter = LocationEntityConverter()
        
        // When
        let locationEntity = converter.convert(input: location, in: mockManagedObjectContext)
        
        // Then
        XCTAssertNotNil(locationEntity, "LocationEntity should not be nil")
        XCTAssertEqual(locationEntity?.cityName, location.city, "LocationEntity cityName should match input location city")
        XCTAssertEqual(locationEntity?.state, location.state, "LocationEntity state should match input location state")
        XCTAssertEqual(locationEntity?.country, location.country, "LocationEntity country should match input location country")
    }
    
    func testConvert_WithNilInput_ShouldReturnNil() {
        // Given
        let converter = LocationEntityConverter()
        
        // When
        let locationEntity = converter.convert(input: nil, in: mockManagedObjectContext)
        
        // Then
        XCTAssertNil(locationEntity, "LocationEntity should be nil when input is nil")
    }
    
    func testConvert_WithPartialInput_ShouldReturnPartialUserEntity() {
        
        // Given
        let user = User(gender: "male", name: nil, location: nil, email: "test@example.com", phone: nil, cell: nil, id: UserID(name: "name", value: "value"), picture: nil, nat: nil)
        let converter = UserEntityConverter()
        
        // When
        let userEntity = converter.convert(input: user, in: mockManagedObjectContext)
        
        // Then
        XCTAssertNotNil(userEntity, "UserEntity should not be nil")
        XCTAssertEqual(userEntity?.id, user.id?.value, "UserEntity id should match input user id")
    }

}
