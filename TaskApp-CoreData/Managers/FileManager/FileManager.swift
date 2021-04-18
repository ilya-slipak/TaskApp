//
//  FileManager.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 09.01.2021.
//

import Foundation

extension FileManager {
    
    static let imageStorage: FileStorable = FileStorage(name: Constants.imageStorage)
    static let videoStorage: FileStorable = FileStorage(name: Constants.videoStorage)
    
    static func removeAll()  {

        imageStorage.removeAll()
        videoStorage.removeAll()
    }
}

// MARK: - Constants

extension FileManager {
    
    struct Constants {
        
        static let imageStorage = "Image"
        static let videoStorage = "Video"
    }
}
