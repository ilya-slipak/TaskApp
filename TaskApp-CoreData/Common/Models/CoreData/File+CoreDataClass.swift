//
//  File+CoreDataClass.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 10.01.2021.
//
//

import Foundation
import CoreData

@objc(File)
public class File: NSManagedObject {

    convenience init(filename: String,
                     context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.filename = filename
        self.createdAt = Date()
        self.identifier = UUID()
    }
}
