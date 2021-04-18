//
//  TaskDatabaseManager.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 11.01.2021.
//

import Foundation

protocol TaskDatabaseManagerProtocol {
    
    func create(title: String, description: String, images: [ImageModel])
    func updateStatus(_ task: Task, newStatus: Task.Status)
    func delete(_ task: Task)
}

final class TaskDatabaseManager {

}

extension TaskDatabaseManager: TaskDatabaseManagerProtocol {
    
    func create(title: String, description: String, images: [ImageModel]) {
        
        DatabaseManager.shared.create(on: .mainQueueConcurrencyType) { context in
            _ = Task(title: title,
                     description: description,
                     images: images,
                     context: context)
            DatabaseManager.shared.save()
        }
    }
  
    func updateStatus(_ task: Task, newStatus: Task.Status) {
        
        task.status = newStatus.rawValue
        DatabaseManager.shared.save()
    }
    
    func delete(_ task: Task) {
        
        DatabaseManager.shared.delete(task)
    }
}
