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
                     images: [ImageModel],
                     context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.title = title
        self.info = description
        self.createdAt = Date()
        self.status = "pending"
        self.identifier = UUID()
        
        images.forEach { image in
            
            let file = File(originalFilename: image.originalURL.lastPathComponent,
                            thumbnailFilename: image.thumbnailURL.lastPathComponent,
                            context: context)
            addToPhotoAttachments(file)
        }
    }
}
