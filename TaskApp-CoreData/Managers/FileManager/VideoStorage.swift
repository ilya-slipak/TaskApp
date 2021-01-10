//
//  VideoFileManager.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 10.01.2021.
//

import Foundation

final class VideoStorage {
    
    static let shared = VideoStorage()
    
    // MARK: - Properties
    
    var documentDirectory: URL? {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory: URL = paths[0]
        let dataPath = documentsDirectory.appendingPathComponent("Videos")
        
        if !FileManager.default.fileExists(atPath: dataPath.path) {
            
            do {
                try FileManager.default.createDirectory(at: dataPath, withIntermediateDirectories: false, attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
                return nil
            }
        }
        
        return dataPath
    }
}

// MARK: - FileStorable

extension VideoStorage: FileStorage {
    
    func saveFile(data: Data?) -> URL? {
        
        guard
            let directory = documentDirectory,
            let fileData = data else {
            return nil
        }
        
        let fileName = "\(UUID().uuidString.lowercased()).mp4"
        let dataPath = directory.appendingPathComponent(fileName)
        
        if !FileManager.default.fileExists(atPath: dataPath.path) {
            do {
                try fileData.write(to: dataPath)
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
        
        return dataPath
    }
    
    func removeAll() {
        
        guard let directory = documentDirectory else {
            return
        }
        
        deleteFile(directory.absoluteString)
    }
}
