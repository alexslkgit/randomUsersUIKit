//
//  CoreDataStack.swift
//  Users App UIKit
//

import CoreData

class CoreDataStack {
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                debugPrint(Constants.ErrorMessage.coreDataImposibleToLoadStore(error))
            }
        }
        
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Log error and send analitycs event to Firebase
                debugPrint(Constants.ErrorMessage.coreDataImposibleToSaveContext(error))
            }
        }
    }
    
    func newBackgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
}
