//
//  UIStoryboard+MakeController.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 07.01.2021.
//

import UIKit

extension UIStoryboard {
    
    static func makeController(name: String, identifier: String) -> UIViewController {
        
        return UIStoryboard(name: name, bundle: nil)
            .instantiateViewController(identifier: identifier)
    }
}
