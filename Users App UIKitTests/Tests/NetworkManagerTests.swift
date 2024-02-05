//
//  NetworkManagerTests.swift
//  Random Users UIKitTests
//

import XCTest
@testable import Random_Users_UIKit

class NetworkManagerUrlSessionTests: XCTestCase {
    
    var networkManager: NetworkManagerUrlSession!
    var mockSession: URLSession!

    override func setUp() {
        super.setUp()
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        mockSession = URLSession(configuration: config)
        networkManager = NetworkManagerUrlSession(session: mockSession)
    }

    override func tearDown() {
        networkManager = nil
        mockSession = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.responseError = nil
        super.tearDown()
    }

    func testFetchUsersSuccessReturnsUsers() {
        
        // Given
        let users = [User(gender: "male", name: Name(title: "Mr", first: "John", last: "Doe"), location: Location(street: Street(number: 123, name: "Main St"), city: "Anytown", state: "Anystate", country: "Anyland"), email: "john@example.com", phone: "555-1234", cell: "555-5678", id: UserID(name: "SSN", value: "123-45-6789"), picture: Picture(large: "large.jpg", medium: "medium.jpg", thumbnail: "thumbnail.jpg"), nat: "US")]
        let data = try? JSONEncoder().encode(RandomUsersList(results: users, info: nil))
        MockURLProtocol.stubResponseData = data

        let expect = expectation(description: "Completion handler invoked")
        var fetchedUsers: [User]?
        var responseError: Error?

        // When
        networkManager.fetchUsers { result in
            switch result {
            case .success(let users):
                fetchedUsers = users
            case .failure(let error):
                responseError = error
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)

        // Then
        XCTAssertNil(responseError)
        XCTAssertEqual(fetchedUsers?.count, users.count)
    }
    
    func testFetchUsersFailureReturnsError() {
        
        // Given
        let error = NSError(domain: "NetworkError", code: 404, userInfo: nil)
        MockURLProtocol.responseError = error

        let expect = expectation(description: "Completion handler invoked")
        var fetchedUsers: [User]?
        var responseError: Error?

        // When
        networkManager.fetchUsers { result in
            switch result {
            case .success(let users):
                fetchedUsers = users
            case .failure(let receivedError):
                responseError = receivedError
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)

        // Then
        XCTAssertNotNil(responseError)
        XCTAssertNil(fetchedUsers)
    }

    func testFetchUsersSuccessReturnsCorrectUsers() {
        
        // Given
        let mockUser = User(gender: "male", name: Name(title: "Mr", first: "John", last: "Doe"), location: Location(street: Street(number: 123, name: "Main St"), city: "Anytown", state: "Anystate", country: "Anyland"), email: "john@example.com", phone: "555-1234", cell: "555-5678", id: UserID(name: "SSN", value: "123-45-6789"), picture: Picture(large: "large.jpg", medium: "medium.jpg", thumbnail: "thumbnail.jpg"), nat: "US")
        let data = try? JSONEncoder().encode(RandomUsersList(results: [mockUser], info: nil))
        MockURLProtocol.stubResponseData = data

        let expect = expectation(description: "Completion handler invoked")
        var fetchedUsers: [User]?
        var responseError: Error?

        // When
        networkManager.fetchUsers { result in
            switch result {
            case .success(let users):
                fetchedUsers = users
            case .failure(let error):
                responseError = error
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)

        // Then
        XCTAssertNil(responseError)
        XCTAssertEqual(fetchedUsers?.first?.id?.value, mockUser.id?.value)
    }

    func testFetchUsersSuccessReturnsZeroUsers() {
        
        // Given
        let data = try? JSONEncoder().encode(RandomUsersList(results: [], info: nil))
        MockURLProtocol.stubResponseData = data

        let expect = expectation(description: "Completion handler invoked")
        var fetchedUsers: [User]?
        var responseError: Error?

        // When
        networkManager.fetchUsers { result in
            switch result {
            case .success(let users):
                fetchedUsers = users
            case .failure(let error):
                responseError = error
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)

        // Then
        XCTAssertNil(responseError)
        XCTAssertTrue(fetchedUsers?.isEmpty ?? false)
    }
}
