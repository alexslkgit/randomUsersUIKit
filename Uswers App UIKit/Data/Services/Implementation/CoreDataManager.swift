//
//  CoreDataService.swift
//  Users App UIKit
//

import CoreData

class CoreDataManager: DataManager {
    
    private let coreDataStack: CoreDataStack
    private let context: NSManagedObjectContext

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.context = coreDataStack.newBackgroundContext()
    }
    
    func saveUsers(_ users: [User]) async throws -> (Void)  {
        
        try await context.perform {
            let userConverter = UserEntityConverter()
            let locationConverter = LocationEntityConverter()
            let nameConverter = NameEntityConverter()
            let pictureConverter = PictureEntityConverter()
            
            for user in users {
                guard let userEntity = userConverter.convert(input: user, in: self.context) else { continue }
                userEntity.location = locationConverter.convert(input: user.location, in: self.context)
                userEntity.name = nameConverter.convert(input: user.name, in: self.context)
                userEntity.picture = pictureConverter.convert(input: user.picture, in: self.context)
            }
            
            try self.context.save()
        }
    }
    
    func fetchCachedUsers() async throws -> [UserEntity] {
        
        return try await self.context.perform {
            let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
            return try self.context.fetch(request)
        }
    }
    
}
