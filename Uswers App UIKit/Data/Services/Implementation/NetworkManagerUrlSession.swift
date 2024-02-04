//
//  NetworkManager.swift
//  Uswers App UIKit
//
import Foundation

class NetworkManagerUrlSession: NetworkManager {
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        
        let urlString = "https://randomuser.me/api/?results=100"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = session.customDataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(.error(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let usersResponse = try JSONDecoder().decode(RandomUsersList.self, from: data)
                completion(.success(usersResponse.results ?? []))
            } catch {
                completion(.failure(.decodeError))
            }
        }
        
        task.resume()
    }
}
