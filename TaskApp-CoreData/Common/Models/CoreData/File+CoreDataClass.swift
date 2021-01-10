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

    convenience init(originalFilename: String,
                     thumbnailFilename: String,
                     context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.originalFilename = originalFilename
        self.thumbnailFilename = thumbnailFilename
        self.createdAt = Date()
        self.identifier = UUID()
    }
}
