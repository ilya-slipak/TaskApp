//
//  ValidationConvertible.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 08.01.2021.
//

import Foundation

protocol ValidatorConvertible: class {
    
    func validated(_ value: String?) throws -> String
}
