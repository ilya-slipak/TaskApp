//
//  TaskDatabaseManager.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 11.01.2021.
//

import Foundation

final class TaskDatabaseManager {
    
    static let shared = TaskDatabaseManager()
    
    func createTask(title: String, description: String, images: [ImageModel]) {
        
        let context = DatabaseManager.shared.context
        _ = Task(title: title,
                        description: description,
                        images: images,
                        context: context)
        DatabaseManager.shared.saveContext()
    }
    
    func deleteTask(_ task: Task) {
        
        DatabaseManager.shared.deleteEntity(task)
    }
}
