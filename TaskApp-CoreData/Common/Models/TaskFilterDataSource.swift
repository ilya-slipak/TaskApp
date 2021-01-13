//
//  FilterDataSource.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 11.01.2021.
//

import Foundation

enum TaskFilterDataSource: String, CaseIterable {
    
    case all
    case pending
    case accepted
    case completed
    
    var title: String {
        
        switch self {
        case .all:
            return "All"
        case .pending:
            return "Pending"
        case .accepted:
            return "Accepted"
        case .completed:
            return "Completed"
        }
    }
    
    var predicate: NSPredicate? {
        switch self {
        case .all:
            return nil
        default:
            return NSPredicate(format: "%K == %@", #keyPath(Task.status), rawValue)
        }
    }
}
