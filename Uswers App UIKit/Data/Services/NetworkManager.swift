//
//  NetworkManager.swift
//  Random Users UIKit
//

import Foundation

protocol NetworkManager {
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void)
}
