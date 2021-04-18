//
//  DatabaseManager.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 07.01.2021.
//

import Foundation
import CoreData

// MARK: - Typealias

typealias CoreDataBlock = (_ context: NSManagedObjectContext) -> Void

protocol DatabaseManaging {
    
    // MARK: - Properties
    
    var mainContext: NSManagedObjectContext! { get }
    
    // MARK: - Methods
    
    func save()
    func create(on queue: NSManagedObjectContextConcurrencyType, _ block: @escaping CoreDataBlock)
    func delete(_ entity: NSManagedObject)
    func delete(_ entities: [NSManagedObject])
    func fetch<T: NSManagedObject>(object: T.Type,
                                   predicate: NSPredicate?,
                                   sortDescriptors: [NSSortDescriptor]?) throws -> [T]
}

final class DatabaseManager {
    
    static let shared = DatabaseManager()
        
    var mainContext: NSManagedObjectContext!
    
    // MARK: - Private Properties
    
    private var model: NSManagedObjectModel!
    private var backgroundContext: NSManagedObjectContext!
    private var coordinator: NSPersistentStoreCoordinator!
    
    // MARK: - Init
    
    init() {
        
        setup()
    }
    
    // MARK: - Core Data Stack
    
    private func setup() {
        
        guard let documentsUrl = FileManager.default.urls(for: .documentDirectory,
                                                          in: .userDomainMask).last else {
            debugPrint("Failed to read documents url")
            return
        }

        let storageURL = documentsUrl.appendingPathComponent(Constants.storageName)
        model = NSManagedObjectModel.mergedModel(from: nil)
        setupCoordinator(storageURL)
        setupMainContext()
        setupBackgroundContext()
    }
    
    private func setupCoordinator(_ url: URL) {
        
        let options = [NSMigratePersistentStoresAutomaticallyOption: true,
                       NSInferMappingModelAutomaticallyOption: true]
        
        coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                               configurationName: nil,
                                               at: url,
                                               options: options)
        } catch let error as NSError {
            coordinator = nil
            debugPrint("Failed to add persistent store with error \(error)")
        }
    }
    
    private func setupMainContext() {
        
        mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.persistentStoreCoordinator = coordinator
        mainContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
    
    private func setupBackgroundContext() {
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.parent = mainContext
        backgroundContext.automaticallyMergesChangesFromParent = true
        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
    
    private func getContext(using concurrencyType: NSManagedObjectContextConcurrencyType) -> NSManagedObjectContext {
        
        var context: NSManagedObjectContext = mainContext
        switch concurrencyType {
        case .mainQueueConcurrencyType:
            context = mainContext
        case .privateQueueConcurrencyType:
            context = backgroundContext
        default:
            break
        }
        
        return context
    }
    
    private func save(_ context: NSManagedObjectContext) {
        
        guard context.hasChanges else {
            return
        }
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            debugPrint("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

// MARK: - CoreDataDatabaseManaging
 
extension DatabaseManager: DatabaseManaging {

    func fetch<T: NSManagedObject>(object: T.Type,
                                   predicate: NSPredicate?,
                                   sortDescriptors: [NSSortDescriptor]?) throws -> [T] {
        
        let fetchRequest = NSFetchRequest<T>(entityName: "\(T.self)")
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        let models = try mainContext.fetch(fetchRequest)
        
        return models
    }
    
    func create(on queue: NSManagedObjectContextConcurrencyType, _ block: @escaping CoreDataBlock) {
        
        let context = getContext(using: queue)
        context.perform {
            block(context)
        }
    }
    
    func save() {

        save(backgroundContext)
        save(mainContext)
    }
    
    func delete(_ entity: NSManagedObject) {
        
        delete([entity])
    }
    
    func delete(_ entities: [NSManagedObject]) {
        
        for entity in entities {
            
            guard let entityContext = entity.managedObjectContext else {
                return
            }
            
            entityContext.perform { [weak self] in
                entityContext.delete(entity)
                let isLastEntity = entity == entities.last
                if isLastEntity {
                    self?.save()
                }
            }
        }
    }
}

// MARK: - Constants

extension DatabaseManager {
    
    struct Constants {
        
        static let storageName = "TaskAppStorage"
    }
}
