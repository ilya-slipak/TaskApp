//
//  Task+CoreDataProperties.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 07.01.2021.
//
//

import Foundation
import CoreData

extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var title: String?
    @NSManaged public var info: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var status: String?
    @NSManaged public var identifier: UUID?
    @NSManaged public var photoAttachments: NSSet?
    @NSManaged public var videoAttachments: NSSet?

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

// MARK: Generated accessors for videoAttachments
extension Task {

    @objc(addVideoAttachmentsObject:)
    @NSManaged public func addToVideoAttachments(_ value: File)

    @objc(removeVideoAttachmentsObject:)
    @NSManaged public func removeFromVideoAttachments(_ value: File)

    @objc(addVideoAttachments:)
    @NSManaged public func addToVideoAttachments(_ values: NSSet)

    @objc(removeVideoAttachments:)
    @NSManaged public func removeFromVideoAttachments(_ values: NSSet)

}

extension Task : Identifiable {

}
