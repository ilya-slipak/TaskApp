//
//  File+CoreDataClass.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 07.01.2021.
//
//

import Foundation
import CoreData

@objc(File)
public class File: NSManagedObject {

    convenience init(originalData: Data,
                     compressedData: Data,
                     context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.originalData = originalData
        self.compressedData = compressedData
        self.createdAt = Date()
        self.identifier = UUID()
    }
}
