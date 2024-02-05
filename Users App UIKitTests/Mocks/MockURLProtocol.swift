//
//  MockURLProtocol.swift
//  Random Users UIKit
//

import Foundation

class MockURLProtocol: URLProtocol {
    
    static var stubResponseData: Data?
    static var responseError: Error?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let data = MockURLProtocol.stubResponseData {
            client?.urlProtocol(self, didLoad: data)
        }
        if let responseError = MockURLProtocol.responseError {
            client?.urlProtocol(self, didFailWithError: responseError)
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() { }
}

