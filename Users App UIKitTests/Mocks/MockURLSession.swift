//
//  MockURLSession.swift
//  Random Users UIKit
//

import Foundation

class MockURLSession: URLSessionProtocol {
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func customDataTask(with url: URL,
                        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let response = self.response
        let error = self.error
        return MockDataTask {
            completionHandler(data, response, error)
        }
    }
}
