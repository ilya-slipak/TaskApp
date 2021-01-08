//
//  ValidationFactory.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 08.01.2021.
//

import Foundation

enum VaildatorFactory {
    
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        
        switch type {
        case .text:
            return TextValidator()
        }
    }
}
