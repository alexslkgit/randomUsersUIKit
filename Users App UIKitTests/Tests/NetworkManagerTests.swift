//
//  NetworkManagerTests.swift
//  Random Users UIKitTests
//

import XCTest
@testable import Random_Users_UIKit

class NetworkServiceTests: XCTestCase {
    
    var networkService: NetworkManager!
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        networkService = NetworkManager(session: mockURLSession)
    }
    
    override func tearDown() {
        networkService = nil
        mockURLSession = nil
        super.tearDown()
    }
    
    func testFetchUsersSuccessReturnsUsers() {
        let expectedData = "{\"results\": []}".data(using: .utf8)
        mockURLSession.data = expectedData
        let expectation = self.expectation(description: "Completion handler invoked")
        
        var responseError: NetworkError?
        var responseUsers: [User]?
        
        networkService.fetchUsers { result in
            switch result {
            case .success(let users):
                responseUsers = users
            case .failure(let error):
                responseError = error
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseUsers)
    }
    
    func testFetchUsersWithInvalidURLReturnsError() {
        let expectation = self.expectation(description: "Completion handler invoked")
        var responseError: NetworkError?
        var responseUsers: [User]?
        
        networkService.fetchUsers { result in
            switch result {
            case .success(let users):
                responseUsers = users
            case .failure(let error):
                responseError = error
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(responseError)
        XCTAssertNil(responseUsers)
    }
    
    func testFetchUsersWithErrorFromServerReturnsError() {
        mockURLSession.error = NSError(domain: "", code: 0, userInfo: nil)
        let expectation = self.expectation(description: "Completion handler invoked")
        var responseError: NetworkError?
        
        networkService.fetchUsers { result in
            if case .failure(let error) = result {
                responseError = error
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(responseError)
        if case .error(let errorMessage) = responseError! {
            XCTAssertNotNil(errorMessage)
        }
    }
    
    func testFetchUsersWithNoDataReturnsError() {
        mockURLSession.data = nil
        let expectation = self.expectation(description: "Completion handler invoked")
        var responseError: NetworkError?
        
        networkService.fetchUsers { result in
            if case .failure(let error) = result {
                responseError = error
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(responseError)
        XCTAssertEqual(responseError, .noData)
    }
    
    func testFetchUsersWithDecodingErrorReturnsError() {
        let invalidData = "Invalid data".data(using: .utf8)
        mockURLSession.data = invalidData
        let expectation = self.expectation(description: "Completion handler invoked")
        var responseError: NetworkError?
        
        networkService.fetchUsers { result in
            if case .failure(let error) = result {
                responseError = error
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(responseError)
        XCTAssertEqual(responseError, .decodeError)
    }
    
    func testFetchUsersWithStatusCode200() {
        let urlResponse = HTTPURLResponse(url: URL(string: "https://randomuser.me/api")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        mockURLSession.response = urlResponse
        let expectedData = "{\"results\": []}".data(using: .utf8)
        mockURLSession.data = expectedData
        let expectation = self.expectation(description: "Completion handler invoked")
        
        var responseError: NetworkError?
        var responseUsers: [User]?
        
        networkService.fetchUsers { result in
            switch result {
            case .success(let users):
                responseUsers = users
            case .failure(let error):
                responseError = error
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseUsers)
    }

    func testFetchUsersWithStatusCode404() {
        let urlResponse = HTTPURLResponse(url: URL(string: "https://randomuser.me/api")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        mockURLSession.response = urlResponse
        mockURLSession.data = nil
        let expectation = self.expectation(description: "Completion handler invoked")
        
        var responseError: NetworkError?
        
        networkService.fetchUsers { result in
            if case .failure(let error) = result {
                responseError = error
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(responseError)
        if case .error(let errorMessage) = responseError! {
            XCTAssertNotNil(errorMessage)
        }
    }

    func testFetchUsersWithStatusCode500() {
        let urlResponse = HTTPURLResponse(url: URL(string: "https://randomuser.me/api")!, statusCode: 500, httpVersion: nil, headerFields: nil)
        mockURLSession.response = urlResponse
        mockURLSession.data = nil
        let expectation = self.expectation(description: "Completion handler invoked")
        
        var responseError: NetworkError?
        
        networkService.fetchUsers { result in
            if case .failure(let error) = result {
                responseError = error
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(responseError)
        if case .error(let errorMessage) = responseError! {
            XCTAssertNotNil(errorMessage)
        }
    }

    func testFetchUsersWithInvalidJSONResponse() {
        let urlResponse = HTTPURLResponse(url: URL(string: "https://randomuser.me/api")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        mockURLSession.response = urlResponse
        let invalidData = "{\"invalid\": ]".data(using: .utf8)
        mockURLSession.data = invalidData
        let expectation = self.expectation(description: "Completion handler invoked")
        
        var responseError: NetworkError?
        
        networkService.fetchUsers { result in
            if case .failure(let error) = result {
                responseError = error
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(responseError)
        XCTAssertEqual(responseError, .decodeError)
    }

}
