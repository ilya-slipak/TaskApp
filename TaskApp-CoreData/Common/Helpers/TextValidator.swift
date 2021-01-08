//
//  Validator.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 08.01.2021.
//

import Foundation

final class TextValidator: ValidatorConvertible {
    
    func validated(_ value: String?) throws -> String {
        
        if let value = value, !value.trimmingCharacters(in: .whitespaces).isEmpty {
            return value
        } else {
            throw ValidationError("Invalid text")
        }
    }
}

