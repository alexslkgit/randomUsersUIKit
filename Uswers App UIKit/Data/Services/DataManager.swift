//
//  DataManager.swift
//  Random Users UIKit
//

import Foundation

protocol DataManager {
    func saveUsers(_ users: [User], completion: @escaping (Error?) -> ())
    func fetchCachedUsers(completion: @escaping (Result<[UserEntity], Error>) -> ())
}
