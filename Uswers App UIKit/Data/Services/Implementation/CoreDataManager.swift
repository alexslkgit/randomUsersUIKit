//
//  CoreDataService.swift
//  Users App UIKit
//
//  Created by Slobodianiuk Oleksandr on 28.01.2024.
//

import CoreData

class CoreDataManager: DataManager {
    
    private let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }

    func saveUsers(_ users: [User], completion: @escaping (Error?) -> ()) {
        
        let context = coreDataStack.newBackgroundContext()
        context.perform {
            let userConverter = UserEntityConverter()
            let locationConverter = LocationEntityConverter()
            let nameConverter = NameEntityConverter()
            let pictureConverter = PictureEntityConverter()

            for user in users {
                guard let userEntity = userConverter.convert(input: user, in: context) else { continue }
                userEntity.location = locationConverter.convert(input: user.location, in: context)
                userEntity.name = nameConverter.convert(input: user.name, in: context)
                userEntity.picture = pictureConverter.convert(input: user.picture, in: context)
            }

            do {
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }

    func fetchCachedUsers(completion: @escaping (Result<[UserEntity], Error>) -> ()) {
        
        let context = coreDataStack.newBackgroundContext()
        context.perform {
            let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
            do {
                let users = try context.fetch(request)
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
