//
//  DatabaseManager.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 07.01.2021.
//

import Foundation
import CoreData

protocol DatabaseManagerProtocol {
    
    // MARK: - Properties
    
    var context: NSManagedObjectContext { get }
    
    // MARK: - Methods
    
    func saveContext ()
    func deleteEntity(_ entity: NSManagedObject)
    func deleteEntities(_ entities: [NSManagedObject])
    func fetchEntities<T: NSManagedObject>(object: T.Type,
                                           predicate: NSPredicate?) throws -> [T]
}

final class DatabaseManager {
    
    static let shared = DatabaseManager()
        
    // MARK: - Core Data stack
    
    private lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "TaskApp_CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                debugPrint("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

extension DatabaseManager: DatabaseManagerProtocol {
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func fetchEntities<T: NSManagedObject>(object: T.Type,
                                           predicate: NSPredicate?) throws -> [T] {
        
        let fetchRequest = NSFetchRequest<T>(entityName: "\(T.self)")
        fetchRequest.predicate = predicate
        let models = try context.fetch(fetchRequest)
        
        return models
    }
    
    func deleteEntity(_ entity: NSManagedObject) {
        
        deleteEntities([entity])
    }
    
    func deleteEntities(_ entities: [NSManagedObject]) {
        
        entities.forEach { entity in
            context.delete(entity)
        }
        saveContext()
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                debugPrint("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
