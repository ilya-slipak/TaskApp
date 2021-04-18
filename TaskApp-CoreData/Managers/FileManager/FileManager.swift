//
//  FileManager.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 09.01.2021.
//

import Foundation

extension FileManager {
    
    static let imageStorage: FileStorable = FileStorage(name: Constants.imageStorageName)
    static let videoStorage: FileStorable = FileStorage(name: Constants.videoStorageName)
    
    static func removeAll()  {

        imageStorage.removeAll()
        videoStorage.removeAll()
    }
}

// MARK: - Constants

extension FileManager {
    
    struct Constants {
        
        static let imageStorageName = "Image"
        static let videoStorageName = "Video"
    }
}
