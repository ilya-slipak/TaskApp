//
//  File+CoreDataProperties.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 07.01.2021.
//
//

import Foundation
import CoreData

extension File {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<File> {
        return NSFetchRequest<File>(entityName: "File")
    }

    @NSManaged public var originalData: Data?
    @NSManaged public var compressedData: Data?
    @NSManaged public var createdAt: Date?
    @NSManaged public var identifier: UUID?
    @NSManaged public var photoRelationship: Task?
    @NSManaged public var videoRelationship: Task?

}

extension File : Identifiable {

}
