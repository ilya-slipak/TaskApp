//
//  Task+CoreDataClass.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 10.01.2021.
//
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {

    convenience init(title: String,
                     description: String,
                     photoAttachements: [File],
                     context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.title = title
        self.info = description
        self.createdAt = Date()
        self.status = "pending"
        self.identifier = UUID()
        
        photoAttachements.forEach { file in
            addToPhotoAttachments(file)
        }
    }
   
}
