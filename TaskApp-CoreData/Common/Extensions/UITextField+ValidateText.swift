//
//  UITextField+ValidateText.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 08.01.2021.
//

import UIKit

extension UITextField {
    
    func validatedText(validationType: ValidatorType) throws -> String {
        
        let validator = VaildatorFactory.validatorFor(type: validationType)
        return try validator.validated(text)
    }
}
