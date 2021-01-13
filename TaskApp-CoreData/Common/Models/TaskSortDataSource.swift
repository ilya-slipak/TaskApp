//
//  SortDataSource.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 11.01.2021.
//

import Foundation

enum TaskSortDataSource: CaseIterable {
    
    case createdAtAscending
    case createdAtDescending
    case inAlphabeticalAscending
    case inAlphabeticalDescending
    
    var title: String {
        
        switch self {

        case .createdAtAscending:
            return "by date of creation ascending"
        case .createdAtDescending:
            return "by date of creation descending"
        case .inAlphabeticalAscending:
            return "in alphabetical order ascending"
        case .inAlphabeticalDescending:
            return "in alphabetical order descending"
        }
    }
    
    var sortDescriptors: [NSSortDescriptor] {
        
        var sortDescriptors: [NSSortDescriptor] = []
        let statusSort = NSSortDescriptor(key: #keyPath(Task.status), ascending: true)
        sortDescriptors.append(statusSort)
        
        switch self {

        case .createdAtAscending:
            let createdAtSort = NSSortDescriptor(key: #keyPath(Task.createdAt), ascending: true)
            sortDescriptors.append(createdAtSort)
        case .createdAtDescending:
            let createdAtSort = NSSortDescriptor(key: #keyPath(Task.createdAt), ascending: false)
            sortDescriptors.append(createdAtSort)
        case .inAlphabeticalAscending:
            let nameSort = NSSortDescriptor(key: #keyPath(Task.title), ascending: true)
            sortDescriptors.append(nameSort)
        case .inAlphabeticalDescending:
            let nameSort = NSSortDescriptor(key: #keyPath(Task.title), ascending: false)
            sortDescriptors.append(nameSort)
        }
        
        return sortDescriptors
    }
}
