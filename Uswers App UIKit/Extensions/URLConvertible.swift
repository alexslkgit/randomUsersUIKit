//
//  URLConvertible.swift
//  Random Users UIKit
//

import Foundation

protocol URLConvertible {
    func asURL() -> URL?
}

extension String: URLConvertible {
    func asURL() -> URL? {
        return URL(string: self)
    }
}

extension URL: URLConvertible {
    func asURL() -> URL? {
        return self
    }
}
