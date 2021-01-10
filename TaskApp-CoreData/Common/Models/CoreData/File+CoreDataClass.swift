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

    convenience init(originalPath: String,
                     compressedPath: String,
                     context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.originalPath = originalPath
        self.thumbnailPath = compressedPath
        self.createdAt = Date()
//        self.identifier = UUID()
    }
}
