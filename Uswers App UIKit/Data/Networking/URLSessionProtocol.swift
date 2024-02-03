//
//  URLSessionProtocol.swift
//  Random Users UIKit
//

import Foundation

protocol URLSessionProtocol {
    func customDataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {
    func customDataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url, completionHandler: completionHandler)
    }
}