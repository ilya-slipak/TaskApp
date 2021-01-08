//
//  ValidationError.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 08.01.2021.
//

import Foundation

struct ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}
