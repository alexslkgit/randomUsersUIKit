//
//  NetworkError.swift
//  Random Users UIKit
//

import Foundation

enum NetworkError: Error, Equatable {

    case invalidURL
    case error(String)
    case noData
    case decodeError
    case invalidResponse
}
