//
//  UserEntityToUIConverter.swift
//  Users App UIKit
//

import Foundation

class UserEntityToUIConverter: ToUIConverter {
    
    func mapToUI(userEntity: UserEntity?) -> UserUI? {
        
        guard let userEntity = userEntity else { return nil }
        
        return UserUI(
            id: userEntity.id ?? UUID().uuidString,
            name: [userEntity.name?.first, userEntity.name?.last].compactMap { $0 }.joined(separator: " "),
            location: [userEntity.location?.cityName,
                       userEntity.location?.state,
                       userEntity.location?.country].compactMap { $0 }.joined(separator: ", "),
            thumbnailURL: userEntity.picture?.thumbnail ?? "",
            mediumImageURL: userEntity.picture?.medium ?? "",
            largeImageURL: userEntity.picture?.large ?? ""
        )
    }
}
