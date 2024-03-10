//
//  DataParser.swift
//  Random Users UIKit
//

import Foundation

class DataParser {
    
    func parse<T: Decodable>(from data: Data, type: T.Type) throws -> T {
        do {
            let responseObject = try JSONDecoder().decode(T.self, from: data)
            return responseObject
        } catch {
            throw NetworkError.error(error.localizedDescription)
        }
    }
}


