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
    @NSManaged public var status: Int16
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

// MARK: - Identifiable

extension Task : Identifiable {

}

// MARK: - Status

extension Task {
    
    enum Status: Int16 {
        
        case pending
        case accepted
        case completed
        
        var title: String {
            switch self {
            
            case .pending:
                return "Pending"
            case .accepted:
                return "Accepted"
            case.completed:
                return "Completed"
            }
        }
    }
    
    var taskStatus: Status? {
        
        return Status(rawValue: status)
    }
}

// MARK: - Sort and Filter rules

extension Task {
    
    static func makeSortDescriptors(for type: TaskSortDataSource) -> [NSSortDescriptor] {
        
        var sortDescriptors: [NSSortDescriptor] = []

        let statusSort = NSSortDescriptor(key: #keyPath(Task.status), ascending: true)
        sortDescriptors.append(statusSort)
        
        switch type {
        
        case .createdAtAscending:
            let createdAtSort = NSSortDescriptor(key: #keyPath(Task.createdAt), ascending: true)
            sortDescriptors.append(createdAtSort)
        case .createdAtDescending:
            let createdAtSort = NSSortDescriptor(key: #keyPath(Task.createdAt), ascending: false)
            sortDescriptors.append(createdAtSort)
        case .inAlphabeticalAscending:
            let nameSort = NSSortDescriptor(key: #keyPath(Task.title), ascending: true)
            sortDescriptors.append(nameSort)
        case .inAlphabeticalDescending:
            let nameSort = NSSortDescriptor(key: #keyPath(Task.title), ascending: false)
            sortDescriptors.append(nameSort)
        }
        
        return sortDescriptors
    }
    
    static func makePredicate(for type: TaskFilterDataSource) -> NSPredicate? {
        
        switch type {
        case .all:
            return nil
        default:
            return NSPredicate(format: "status == %i", type.priority)
//            return NSPredicate(format: "%K == %@", #keyPath(Task.status), type.rawValue)
        }
    }
}
