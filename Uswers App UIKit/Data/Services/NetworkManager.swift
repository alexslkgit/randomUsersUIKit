//
//  NetworkManager.swift
//  Random Users UIKit
//

import Foundation

protocol NetworkManager {
    func fetchUsers() async throws -> [User]
}
