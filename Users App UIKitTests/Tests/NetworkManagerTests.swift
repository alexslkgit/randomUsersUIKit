//
//  NetworkManagerTests.swift
//  Random Users UIKitTests
//

import XCTest
@testable import Random_Users_UIKit

class NetworkManagerUrlSessionTests: XCTestCase {
    
    var sut: NetworkManagerUrlSession!
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        
        mockURLSession = MockURLSession()
        sut = NetworkManagerUrlSession(session: mockURLSession)
    }
    
    override func tearDown() {
        sut = nil
        mockURLSession = nil
        super.tearDown()
    }
    
    func testFetchUsersSuccessReturnsUsers() {
        let users = [User(gender: "male", name: Name(title: "Mr", first: "John", last: "Doe"), location: Location(street: Street(number: 123, name: "Main St"), city: "Anytown", state: "Anystate", country: "Anyland"), email: "john@example.com", phone: "555-1234", cell: "555-5678", id: UserID(name: "SSN", value: "123-45-6789"), picture: Picture(large: "large.jpg", medium: "medium.jpg", thumbnail: "thumbnail.jpg"), nat: "US")]
        let data = try? JSONEncoder().encode(RandomUsersList(results: users, info: nil))
        mockURLSession.nextData = data
        
        let expect = expectation(description: "Completion handler invoked")
        var fetchedUsers: [User]?
        var responseError: Error?
        sut.fetchUsers { result in
            switch result {
            case .success(let users):
                fetchedUsers = users
            case .failure(let error):
                responseError = error
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(fetchedUsers?.count, users.count)
    }
    
    func testFetchUsersFailureReturnsError() {
        let error = NSError(domain: "NetworkError", code: 404, userInfo: nil)
        mockURLSession.nextError = error
        
        let expect = expectation(description: "Completion handler invoked")
        var fetchedUsers: [User]?
        var responseError: Error?
        sut.fetchUsers { result in
            switch result {
            case .success(let users):
                fetchedUsers = users
            case .failure:
                responseError = error
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertNotNil(responseError)
        XCTAssertNil(fetchedUsers)
    }
}
