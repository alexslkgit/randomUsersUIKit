//
//  MockURLSession.swift
//  Random Users UIKit
//

import Foundation

class MockURLSession: URLSession {
    
    var data: Data?
    var response: URLResponse?
    var error: Error?

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let response = self.response
        let error = self.error
        
        return URLSession.shared.dataTask(with: request) { _, _, _ in
            completionHandler(data, response, error)
        }
    }
}
