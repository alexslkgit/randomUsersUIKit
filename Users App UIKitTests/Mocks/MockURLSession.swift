//
//  MockURLSession.swift
//  Random Users UIKit
//

import Foundation

class MockURLSession: URLSession {
    var nextData: Data?
    var nextError: Error?
    var nextResponse: URLResponse?

    func mockDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = nextData
        let error = nextError
        let response = nextResponse

        return MockURLSessionDataTask {
            completionHandler(data, response, error)
        }
    }

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return mockDataTask(with: request, completionHandler: completionHandler)
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
