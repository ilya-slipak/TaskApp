//
//  File+CoreDataProperties.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 10.01.2021.
//
//

import Foundation
import CoreData


extension File {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<File> {
        return NSFetchRequest<File>(entityName: "File")
    }

    @NSManaged public var originalPath: String?
    @NSManaged public var thumbnailPath: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var photoRelationship: Task?

}

extension File : Identifiable {

}
