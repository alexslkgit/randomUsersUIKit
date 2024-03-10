//
//  NetworkManager.swift
//  Uswers App UIKit
//

import Foundation

class NetworkManagerUrlSession: NetworkManager {
    
    let session: URLSession
    let parser: DataParser
    
    init(session: URLSession = URLSession.shared, 
         parser: DataParser = DataParser()) {
        self.session = session
        self.parser = parser
    }
    
    func fetchUsers() async throws -> [User] {
        
        let urlString = Constants.API.randomUserMockURL
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await session.data(from: url)
        return try parser.parse(from: data, type: RandomUsersList.self).results ?? []
    }
}
