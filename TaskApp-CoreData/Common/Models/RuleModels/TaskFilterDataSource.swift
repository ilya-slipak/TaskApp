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
        
    var priority: Int {
        
        switch self {
        case .all:
            return -1
        case .pending:
            return 0
        case .accepted:
            return 1
        case .completed:
            return 2
        }
    }
}

// MARK: - RuleModel

extension TaskFilterDataSource: PickerRuleModel {
    
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
}
