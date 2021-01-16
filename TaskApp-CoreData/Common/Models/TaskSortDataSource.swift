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
}
