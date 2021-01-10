//
//  Task+CoreDataProperties.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 10.01.2021.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var identifier: UUID?
    @NSManaged public var info: String?
    @NSManaged public var status: String?
    @NSManaged public var title: String?
    @NSManaged public var photoAttachments: NSSet?

}

// MARK: Generated accessors for photoAttachments
extension Task {

    @objc(addPhotoAttachmentsObject:)
    @NSManaged public func addToPhotoAttachments(_ value: File)

    @objc(removePhotoAttachmentsObject:)
    @NSManaged public func removeFromPhotoAttachments(_ value: File)

    @objc(addPhotoAttachments:)
    @NSManaged public func addToPhotoAttachments(_ values: NSSet)

    @objc(removePhotoAttachments:)
    @NSManaged public func removeFromPhotoAttachments(_ values: NSSet)

}

extension Task : Identifiable {

}
