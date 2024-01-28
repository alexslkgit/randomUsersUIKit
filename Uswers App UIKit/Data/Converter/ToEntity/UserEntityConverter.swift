//
//  UserEntityConverter.swift
//  Users App UIKit
//

import Foundation
import CoreData

class UserEntityConverter: ToEntityConverter {
    
    typealias Input = User
    typealias Output = UserEntity

    func convert(input: User?, in context: NSManagedObjectContext) -> UserEntity? {
        
        guard let input else { return nil }

        let userEntity: UserEntity = fetchOrCreate(withId: input.id?.value, in: context)
        userEntity.id = input.id?.value
        return userEntity
    }

    private func fetchOrCreate(withId id: String?, in context: NSManagedObjectContext) -> UserEntity {
        
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id ?? "")
        
        let results = try? context.fetch(request)
        let entity = results?.first ?? UserEntity(context: context)
        return entity
    }
}
