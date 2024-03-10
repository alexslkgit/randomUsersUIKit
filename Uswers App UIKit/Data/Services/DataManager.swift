//
//  DataManager.swift
//  Random Users UIKit
//

import Foundation

protocol DataManager {
    func saveUsers(_ users: [User]) async throws -> (Void)
    func fetchCachedUsers() async throws -> [UserEntity]
}
