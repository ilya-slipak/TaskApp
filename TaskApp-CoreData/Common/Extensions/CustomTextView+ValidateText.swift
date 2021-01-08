//
//  UITextView+Validate.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 08.01.2021.
//

import UIKit

extension CustomTextView {
    
    func validatedText(validationType: ValidatorType) throws -> String {
        
        let validator = VaildatorFactory.validatorFor(type: validationType)
        let text = placeholder == self.text ? "" : self.text
        return try validator.validated(text)
    }
}
