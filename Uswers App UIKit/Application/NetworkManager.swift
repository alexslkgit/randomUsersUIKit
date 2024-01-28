//
//  NetworkService.swift
//  Uswers App UIKit
//
//  Created by Slobodianiuk Oleksandr on 23.01.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case error(String)
    case noData
    case decodeError
}

class NetworkManager {
    
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {

        let urlString = "https://randomuser.me/api/?results=100"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                completion(.failure(.error(error.localizedDescription)))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let usersResponse = try JSONDecoder().decode(Welcome.self, from: data)
                completion(.success(usersResponse.results ?? [])) // Зміни тут
            } catch {
                completion(.failure(.decodeError))
            }
        }

        task.resume()
    }
}
