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
        let taskStatus: Status = .pending
        self.status = taskStatus.rawValue
        self.identifier = UUID()
        
        images.forEach { image in
            
            let file = File(filename: image.originalURL.lastPathComponent,
                            context: context)
            addToPhotoAttachments(file)
        }
    }
}
