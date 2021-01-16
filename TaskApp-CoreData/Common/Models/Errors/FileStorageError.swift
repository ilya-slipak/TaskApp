//
//  FileStorageError.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 16.01.2021.
//

import Foundation

enum FileStorageError {
    
    case emptyStorage
    case emptyFile
}

// MARK: - Error

extension FileStorageError: Error {
    
    var localizedDescription: String {
        
        switch self {
        case .emptyStorage:
            return "Storage doesn't exist"
        case .emptyFile:
            return "There is no file by specified URL"
        }
    }
}
