//
//  VideoFileManager.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 10.01.2021.
//

import Foundation

final class VideoStorage {
    
    static let shared = VideoStorage()
}

// MARK: - FileStorable

extension VideoStorage: FileStorage {
        
    var storageURL: URL? {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory: URL = paths[0]
        let dataPath = documentsDirectory.appendingPathComponent("Videos")
        
        if !FileManager.default.fileExists(atPath: dataPath.path) {
            
            do {
                try FileManager.default.createDirectory(at: dataPath, withIntermediateDirectories: false, attributes: nil)
            } catch {
                debugPrint(error.localizedDescription)
                return nil
            }
        }
        
        return dataPath
    }
}
