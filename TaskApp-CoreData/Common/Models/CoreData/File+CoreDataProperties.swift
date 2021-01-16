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

    @NSManaged public var filename: String
    @NSManaged public var createdAt: Date?
    @NSManaged public var photoRelationship: Task?
    @NSManaged public var identifier: UUID?

}

// MARK: - Identifiable

extension File : Identifiable {

}

// MARK: - MediaModel

extension File: MediaModel {
    
}

