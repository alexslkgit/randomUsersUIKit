//
//  NameEntityConverter.swift
//  Users App UIKit
//

import CoreData

class NameEntityConverter: ToEntityConverter {
    
    typealias Input = Name
    typealias Output = UserNameEntity

    func convert(input: Name?, in context: NSManagedObjectContext) -> UserNameEntity? {
    
        guard let input else { return nil }
    
        let nameEntity = UserNameEntity(context: context)
        nameEntity.title = input.title
        nameEntity.first = input.first
        nameEntity.last = input.last
        return nameEntity
    }
}
